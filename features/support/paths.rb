module NavigationHelpers

  def get_first_title
    @title = find_first_song unless nil?
  end

  private

  def find_first_song
    results = Array.new
    page.all('table tr').each_with_index do |tr,index|
      results << tr.text
      next unless index < 2
    end
    results[1]
  end
end

World(NavigationHelpers)