class Gallery < Component
  has_many :gallery_assets, ->{order(:position)}, inverse_of: :gallery, dependent: :destroy

  def self.permitted_params
    super | [{gallery_assets_attributes: GalleryAsset.permitted_params}]
  end

  accepts_nested_attributes_for :gallery_assets, allow_destroy: true, reject_if: :all_blank
end
