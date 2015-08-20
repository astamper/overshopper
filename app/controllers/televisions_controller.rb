class TelevisionsController < ApplicationController
  def filter
  @filterrific = initialize_filterrific(
      Television,
      params[:filterrific],
      :select_options => {
        sorted_by: Television.options_for_sorted_by,
        with_brand: Television.options_for_select
      },
      persistence_id: "agaragar"
      ) or return
    @televisions = @filterrific.find.page(params[:page])

    respond_to do |format|
      format.html
      format.js
    end
  end
  def result
    @filterrific = initialize_filterrific(
      Television,
      params[:filterrific],
      :select_options => {
        sorted_by: Television.options_for_sorted_by,
        with_brand: Television.options_for_select
      },
      persistence_id: "agaragar"
      ) or return
    @televisions = @filterrific.find.page(params[:page])

    respond_to do |format|
      format.html
      format.js
    end
  end
  def product
  end


end

