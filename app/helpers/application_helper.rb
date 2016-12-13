module ApplicationHelper
  def gravatar_for(user, opts = {})
    opts[:alt] = user.name
    digest_email = Digest::MD5.hexdigest(user.email)
    gravatar_url = "https://www.gravatar.com/avatar/#{digest_email}?s=#{opts.delete(:size) { 40 }}"
    image_tag gravatar_url, opts
  end
end
