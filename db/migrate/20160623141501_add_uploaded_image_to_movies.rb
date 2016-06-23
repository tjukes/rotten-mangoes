class AddUploadedImageToMovies < ActiveRecord::Migration
  def change
    add_column :movies, :uploaded_image, :string
  end
end
