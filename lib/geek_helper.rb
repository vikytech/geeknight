require "premailer"

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

  def generate_html_with_inline_css
    print("Generating mail content...\n")

    premailer = Premailer.new('docs/index.html', :warn_level => Premailer::Warnings::SAFE)
    File.open("docs/index.html", "w") do |fout|
      fout.puts premailer.to_inline_css
    end

    print("Ready to send")
  end

  def groupYearMonths
    return @items.select {|event| !event[:start].nil?}.sort_by { |i| i[:edition]}.reverse.group_by {|i| [i[:start].to_date.year, i[:start].to_date.strftime("%b %d")]}
  end

  def latest
    @@first ||= archives.first
  end
end