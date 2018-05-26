# frozen_string_literal: true

class BuildingRadiusQuery
  RADIUS = 4000

  attr_reader :point

  def initialize(point_lon, point_lat)
    @point = factory.point(point_lon.to_f, point_lat.to_f)
  end

  def in_radius
    Building.select(select_sql)
            .where("ST_DWithin(coordinates, ?, ?)", point, RADIUS)
            .order("distance ASC")
  end

  private

  def select_sql
    <<-SQL
      address, ST_AsText(coordinates) as coordinates,
      #{distance} as distance
    SQL
  end

  def distance
    Arel.sql "ST_DistanceSphere(coordinates::geometry, #{sql_point})"
  end

  def sql_point
    Arel.sql "ST_GeomFromEWKT('SRID=4326;POINT(#{point.longitude} " \
             "#{point.latitude})')"
  end

  def factory
    RGeo::Geographic.spherical_factory(srid: 4326)
  end
end
