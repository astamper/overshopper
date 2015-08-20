class CreateTelevisions < ActiveRecord::Migration
  def change
    create_table :televisions do |t|
      t.string :name
      t.string :imageurl
      t.string :brand
      t.string :modelnumber
      t.string :url
      t.string :description
      t.string :width
      t.float :widthin
      t.float :depthwithstandin
      t.float :depthwithoutstandin
      t.float :heightwithstandin
      t.float :heightwithoutstandin
      t.integer :customerreviewcount
      t.float :customerreviewaverage
      t.string :tvtype
      t.float :regularprice
      t.float :saleprice
      t.timestamps null: false
    end
  end
end
