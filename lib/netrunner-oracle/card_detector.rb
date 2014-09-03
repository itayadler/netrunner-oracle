require 'opencv'
require 'tesseract-ocr'

class CardDetector
  REGULAR_CARD_HEIGHT_PERCENTAGE = 8.33

  def self.detect(image_path)
    image_roi = extract_image_footer(image_path)
    image_text = extract_text_from_image(image_path)
    puts 'image text: ' + image_text
  end

  def self.extract_text_from_image(image_path)
    engine = Tesseract::Engine.new do |e|
      e.language = :eng
      e.blacklist = '|'
    end

    engine.text_for(image_path).strip
  end

  def self.extract_image_footer(image_path)
    img = OpenCV::IplImage.load(image_path)
    roi_height = img.height.to_f * REGULAR_CARD_HEIGHT_PERCENTAGE / 100.0
  end
end

CardDetector.detect(ARGV[0])
