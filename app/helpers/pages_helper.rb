require 'google/api_client'
require 'will_paginate/array'

module PagesHelper

  def search searchword, max_results
    client, youtube = get_service

    begin
      # Call the search.list method to retrieve the result matching the searchword
      search_response = client.execute!(
          api_method: youtube.search.list,
          parameters: {
              part: 'snippet',
              q: searchword,
              maxResults: max_results,
              type: 'video'
          }
      )

      # Return matching results
      return search_response.data.items

    rescue Google::APIClient::TransmissionError => e
      puts e.result.body
    end
  end


  # Initialize pagination
  def get_pagination results
    results.paginate(page: params[:page], per_page: 10)
  end


  def print_search_result searchword, result
    unless searchword.nil? || searchword.empty?
      if result.empty?
        "No results for '#{searchword}'"
      else
        "Results for '#{searchword}'"
      end
    end
  end


  def get_current_user
    unless current_user.nil?
      if current_user.provider.eql? 'facebook'
        current_user.first_name
      else
      current_user.first_name + ' ' + current_user.last_name
      end
    end
  end


  def get_profile_picture user
    if user.profile_picture.blank?
      img = "https://s3-us-west-2.amazonaws.com/tubefedzt-assets/default_user_icon.png"
    else
      img = current_user.profile_picture.url(:square)
    end

    image_tag(img, width: 150)
  end


  private


  def get_service
    client = Google::APIClient.new(
        key: ENV['YOUTUBE_APP_ID'],
        authorization: nil,
        application_name: 'TubeFedzt',
        applicatioN_version: '1.0.0',
    )

    youtube = client.discovered_api(ENV['YOUTUBE_API_SERVICENAME'], ENV['YOUTUBE_API_VERSION'])

    return client, youtube
  end
end
