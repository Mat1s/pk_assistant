class Service < ApplicationRecord
  has_many :service_for_organizations
  has_many :organizations, through: :service_for_organizations
  has_many :organization_addresses, through: :organizations

  belongs_to :service_type

  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks




  def as_indexed_json(options={})
    self.as_json({
      only: [:name_en, :name_ru, :name_es]
    })
  end
  settings index: { number_of_shards: 1 } do
    mappings dynamic: 'false' do
        indexes :name_en,      type: :text, analyzer: :english
        indexes :name_ru,      type: :text, analyzer: :russian
        indexes :name_es,      type: :text, analyzer: :spanish
  	end
  end

  def self.suggest(query)
    __elasticsearch__.search(
      {
        suggest: {
          'service-for-organizations-suggest': {
            prefix: query,
            completion: {
              field: name_en,
              fuzzy: {
                fuzziness: 2
              }  
            }
          }
        }
      }
    )
   end
end
