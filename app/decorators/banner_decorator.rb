class BannerDecorator < ComponentDecorator
  def background *args
    if object.video_mp4.try(:file).try(:exists?) && object.video_ogg.try(:file).try(:exists?)
      content_tag :div, class: 'background-video-wrapper' do
        output = ''
        output << video_tag([object.video_mp4_url, object.video_ogg_url], autoplay: true, loop: true)
        output << image_tag(object.background_url(:large))
        output << '<div class="mask"></div>'
        output.html_safe
      end
    else
      super
    end
  end
end
