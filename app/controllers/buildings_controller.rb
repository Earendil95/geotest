class BuildingsController < ApplicationController
  def search
    @buildings = BuildingRadiusQuery.new(*point_params).in_radius(params[:radius]&.to_f)
    render layout: false
  end

  private

  def point_params
    p = params.permit(:lon, :lat)
    [p[:lon], p[:lat]]
  end
end
