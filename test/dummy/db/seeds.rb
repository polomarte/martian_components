def create_html_paragraphs count
  Faker::Lorem.paragraphs(count).map{|p| "<p>#{p}</p>"}.join('')
end

def open_file path
  File.open("#{Rails.root}/db/files/#{path}")
end

def build_image kind, path
  Image.new(kind: kind, file: open_file(path))
end

def build_document path
  Document.new(file: open_file(path))
end

def load_yaml path
  YAML.load_file "#{Rails.root}/db/data/files/#{path}"
end

AdminUser.create(email: 'mc@outracoisa.co', password: 'admin123')

Component.destroy_all

Banner.create!(
  key: 'app:banner:banner_a',
  title: 'Cabeçalho',
  h1: 'New Title',
  h2: 'A Subtitle',
  images: [
    build_image('icon', 'icon.png'),
    build_image('background', 'bg.jpg')],
  options: {data: {full_height_header: true}})

KnowMoreLinks.create!(
  key: 'app:know_more_links:know_more_links_a',
  title: 'Saiba mais',
  h1: 'Know more')

/
links = [
      KnowMoreLink.create!(
        key: 'app:know_more_link:know_more_link_1',
        h1: 'Link 1',
        images: [
          build_image('background', 'icon.png'),
          build_image('icon', 'bg.jpg')],
        form_options: {
          additional_editable_attrs: [:link_url],
          disabled_attrs: [:text]}),
    
      KnowMoreLink.create!(
        key: 'app:know_more_link:know_more_link_2',
        h1: 'Link 2',
        images: [
          build_image('background', 'icon.png'),
          build_image('icon', 'bg.jpg')],
        form_options: {
          additional_editable_attrs: [:link_url],
          disabled_attrs: [:text]}),
    
      KnowMoreLink.create!(
        key: 'app:know_more_link:know_more_link_3',
        h1: 'Link 3',
        images: [
          build_image('background', 'icon.png'),
          build_image('icon', 'bg.jpg')],
        form_options: {
          additional_editable_attrs: [:link_url],
          disabled_attrs: [:text]})]

KnowMoreLinks.create!(
  key:          'app:hover_group:highlights',
  h1:           'Em Destaque',
  h2:           'Últimas novidades Amanco',
  links:        links,
  form_options: {only_links: true},
  options: {
    gallery: true,
})
/
