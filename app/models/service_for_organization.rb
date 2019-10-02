class ServiceForOrganization < ApplicationRecord
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  has_many :organization_addresses, through: :organization
  has_one :service_type, through: :service

  belongs_to :service
  belongs_to :organization

  settings index: { number_of_shards: 1 } do
    mappings dynamic: 'false' do
      indexes :service,      type: :object do
        indexes :name_en,      type: :text, analyzer: :english
        indexes :name_ru,      type: :text, analyzer: :russian
        indexes :name_es,      type: :text, analyzer: :spanish
        indexes :service_type, type: :object do
          indexes :type_en,    type: :text, analyzer: :english
          indexes :type_ru,    type: :text, analyzer: :russian
          indexes :type_es,    type: :text, analyzer: :spanish
        end
      end
      indexes :organization, type: :object do
        indexes :name,       type: :keyword
        indexes :email,      type: :keyword
        indexes :phone,      type: :keyword
        indexes :aasm_state, type: :keyword
        indexes :organization_addresses, type: :object do
          indexes :city,     type: :text
          indexes :street,   type: :text
          indexes :house_number, type: :text
          indexes :phone,    type: :keyword
        end
      end
    end
  end

  def as_indexed_json(options={})
    self.as_json(
      include: {
        service: {
          include: [:service_type]
        },
        organization: {
          only: [:name, :email, :phone, :aasm_state],
          include: {
            organization_addresses: {
              only: [:city, :street, :house_number, :phone]
            }
          }
        }
      }
    )
  end
  

  def self.search_published(query, service_type = (1..7).to_a)
    __elasticsearch__.search(
    { from: 0, size: 20,
      query: {
        bool: {
          must: [
            { match: { 'organization.aasm_state': 'published' } },
            {
              multi_match: {
              query: query,
              fields: [ 'service.name_en', 'service.name_ru', 'service.name_es' ],
              fuzziness: 'auto'
              }
            }
          ]
        }
      },
      sort: [{
        'organization.name': 'asc'
      }] 
    }
      # {
      #   query: { 
      #   	constant_score: {
      #   	  filter: {
      #         bool: {
      #           should: [
      #             terms: {
      #               'service.service_type.id': service_type
      #             }
      #           ],
      #           must: [
      #           {
      #             multi_match: {
      #             query: query,
      #             fields: [ 'service.name_en', 'service.name_ru', 'service.name_es',
      #               'service.service_type.type_en', 'service.service_type.type_ru',
      #               'service.service_type.type_es', 'organization.name',
      #               'organization.organization_addresses.city',
      #               'organization.organization_addresses.street' ]
      #             }
      #           },
      #           match: {
      #             'organization.aasm_state': 'published'
      #           }]
      #         }
      #       }
      #     }
      #   }
      # }
    )
  end
end

#   {
#   "mappings": {
#     "_doc": { 
#       "properties": {
#         "region": {
#           "type": "keyword"
#         },
#         "manager": { 
#           "properties": {
#             "age":  { "type": "integer" },
#             "name": { 
#               "properties": {
#                 "first": { "type": "text" },
#                 "last":  { "type": "text" }
#               }
#             }
#           }
#         }
#       }
#     }
#   }
# }
# {
#   "settings": {
#     "index": {
#       "analysis": {
#         "filter": {},
#         "analyzer": {
#           "keyword_analyzer": {
#             "filter": [ "lowercase", "asciifolding", "trim" ],
#             "char_filter": [], "type": "custom", "tokenizer": "keyword"
#           },
#           "edge_ngram_analyzer": {
#             "filter": ["lowercase" ], "tokenizer": "edge_ngram_tokenizer"
#           },
#           "edge_ngram_search_analyzer": { "tokenizer": "lowercase" }
#         },
#         "tokenizer": {
#           "edge_ngram_tokenizer": {
#             "type": "edge_ngram", "min_gram": 2, "max_gram": 5,
#             "token_chars": [ "letter" ]
#           }
#         }
#       }
#     }
#   },
#   "mappings": {
#     "marvels": {
#       "properties": {
#         "name": { "type": "text", "fields": { 
#         	  "keywordstring": {
#               "type": "text", "analyzer": "keyword_analyzer"
#             },
#             "edgengram": { "type": "text", "analyzer": "edge_ngram_analyzer",
#               "search_analyzer": "edge_ngram_search_analyzer"
#             },
#             "completion": {
#               "type": "completion"
#             }
#           },
#           "analyzer": "standard"
#         }
#       }
#     }
#   }
# }
# keywordstringkeywordstringkeywordstringkeywordstringkeywordstring
# {
#   "query": {
#     "prefix": {
#       "name.keywordstring": "am"
#     }
#   }
# }

# edgengramedgengramedgengramedgengramedgengramedgengramedgengram
# {
#   "query": {
#     "match": {
#       "name.edgengram": "am"
#     }
#   }
# }


# suggestsuggestsuggestsuggestsuggestsuggestsuggestsuggestsuggest
# {
#   "suggest": {
#       "movie-suggest" : {
#           "prefix" : "captain america the",
#           "completion" : {
#               "field" : "name.completion"
#           }
#       }
#   }
# }
# suggest-fuzzysuggest-fuzzysuggest-fuzzysuggest-fuzzysuggest-fuzzysuggest-fuzzy
# {
#   "suggest": {
#     "movie-suggest-fuzzy": {
#       "prefix": "captain amerca the",
#       "completion": {
#         "field": "name.completion",
#         "fuzzy": {
#           "fuzziness": 1
#         }
#       }
#     }
#   }
# }



# {
#   "settings": {
#     "index": {
#       "analysis": {
#         "filter": {}
#       }
#     }
#   },
#   "mappings": {
#     "marvels": {
#       "properties": {
#         "name": { "type": "text", "fields": { "completion": { "type": "completion" } },
#           "analyzer": "standard"
#         }
#       }
#     }
#   }
# }
# {
#   "suggest": {
#     "movie-suggest-fuzzy": {
#       "prefix": "captain amerca the",
#       "completion": {
#         "field": "name.completion",
#         "fuzzy": {
#           "fuzziness": 1
#         }
#       }
#     }
#   }
# }



# {
#   "mappings": {
#     "marvels": {
#       "properties": {
#         "name": {
#           "type": "completion"
#         },
#         "year": {
#           "type": "keyword"
#         }
#       }
#     }
#   }
# {
#   "suggest": {
#     "movie-suggest": {
#       "prefix": "thor",
#       "completion": {
#         "field": "name"
#       }
#     }
#   }
# }