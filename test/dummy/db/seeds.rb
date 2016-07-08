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

Test.create!(
  key: 'app:test:test_a',
  title: 'zz',
  h1: 'New Title',
  h2: 'A Subtitle')
