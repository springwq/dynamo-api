class MoviesController < ApplicationController
  def show
    result = dynamodb_client.get_item(table_item)

    render json: {
      Plot: result.item['info']['plot'],
      Rating: result.item['info']['rating'].to_i
    }
  end

  private

  def dynamodb_client
    Aws.config.update(
      region: 'us-east-1'
    )

    Aws::DynamoDB::Client.new
  end

  def table_item
    table_name = 'Movies'
    title = 'The Big New Movie'
    year = 2015

    {
      table_name: table_name,
      key: {
        year: year,
        title: title
      }
    }
  end
end
