 storage :fog

  process :resize_to_fill => [300, 300]

  version :thumb do
    process :resize_to_fill => [50, 50]
  end
