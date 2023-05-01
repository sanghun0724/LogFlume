Pod::Spec.new do |s|
  s.name         = "LogFlume"
  s.version      = "0.1.0"
  s.summary      = "Super Light Logging System in Swift"

  # This description is used to generate tags and improve search results.
  #   * Think: What does it do? Why did you write it? What is the focus?
  #   * Try to keep it short, snappy and to the point.
  #   * Write the description between the DESC delimiters below.
  #   * Finally, don't worry about the indent, CocoaPods strips it!
  s.description  = <<-DESC
LogFlume is a lightweight, scalable, useful, and fast logging library for Swift. With LogFlume, developers can easily add logging functionality to their Swift applications without sacrificing performance. LogFlume is designed to be highly scalable, allowing developers to configure the logging level and output destination according to their needs. Additionally, LogFlume provides a simple and intuitive API that makes it easy for developers to use the library and customize their logging output. Despite its lightweight design, LogFlume is a highly useful logging library that can be used in a wide range of Swift applications. Whether you're building a small utility or a large-scale application, LogFlume is a powerful tool that can help you debug and troubleshoot your code with ease.
                   DESC

  s.homepage     = "https://github.com/sanghun0724/LogFlume"
  s.license      = "MIT"
  s.author       = { "Sangheon Lee" => "sangheon0724@gmail.com" }
  s.ios.deployment_target = "13.0"
  s.source       = { :git => "https://github.com/sanghun0724/LogFlume", :tag => "0.1.0" }
  s.source_files  = "Sources"
end
