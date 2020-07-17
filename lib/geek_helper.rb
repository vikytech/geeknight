module GeekHelper
  def start_date(item=nil)
    item ||= @item
    Time.parse item[:start]
  end

  def archives    
    @items.select do |event|
      !!event[:edition]
    end.sort_by do |event|
      -event[:edition]
    end
  end

  def baseURL
    "https://vikytech.github.io/geeknight/"
  end

  def groupYearMonths
    return @items.select {|event| !event[:start].nil?}.sort_by { |i| i[:edition]}.reverse.group_by {|i| [i[:start].to_date.year, i[:start].to_date.strftime("%b %d")]}
  end

  def latest
    @@first ||= archives.first
  end
end