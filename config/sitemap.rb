# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = "http://www.compost-lyon.fr"
SitemapGenerator::Sitemap.create_index = false

SitemapGenerator::Sitemap.public_path = 'tmp/sitemap'
# Where you want your sitemap.xml.gz file to be uploaded.
SitemapGenerator::Sitemap.adapter = SitemapGenerator::S3Adapter.new(
aws_access_key_id: ENV["S3_ACCESS_KEY"],
aws_secret_access_key: ENV["S3_SECRET_KEY"],
fog_provider: 'AWS',
fog_directory: ENV["S3_BUCKET_NAME"],
fog_region: ENV["S3_REGION"]
)

SitemapGenerator::Sitemap.create do
  # Put links creation logic here.
  #
  # The root path '/' and sitemap index file are added automatically for you.
  # Links are added to the Sitemap in the order they are specified.
  #
  # Usage: add(path, options={})
  #        (default options are used if you don't specify)
  #
  # Defaults: :priority => 0.5, :changefreq => 'weekly',
  #           :lastmod => Time.now, :host => default_host
  #
  # Examples:
  #
  # Add '/articles'
  #
  #   add articles_path, :priority => 0.7, :changefreq => 'daily'
  #
  # Add all articles:
  #
  #   Article.find_each do |article|
  #     add article_path(article), :lastmod => article.updated_at
  #   end
  add 'a-propos'
  add 'composteurs-collectifs'
  Site.find_each do |site|
    add site_path(site), :lastmod => site.updated_at
  end
end
