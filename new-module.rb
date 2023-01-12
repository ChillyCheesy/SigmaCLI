require "down"
require "zip"
require "fileutils"

require_relative "./spinner"


MODULE_ZIP_URL = "https://github.com/ChillyCheesy/SkeletonModule/archive/refs/heads/master.zip"

def new_module(name)
    SPINNER.start
    tempfile = Down.download(MODULE_ZIP_URL)
    Zip::File.open(tempfile.path) do |zip_file|
        zip_file.each do |f|
            f_path=File.join("./", f.name.sub(/([^\/])*\//, name + "/"))
            FileUtils.mkdir_p(File.dirname(f_path))
            zip_file.extract(f, f_path) unless File.exist?(f_path)
        end
    end

    replace_in_folder("./" + name, "skeleton", name)
    FileUtils.mv("./" + name, "./" + name + "Module")

    SPINNER.stop("Module #{name}Module successfully created, you can now start working on it!")
end


def renameFile(file, name)
    # Rename the file
    if file.include?("Skeleton")
        FileUtils.mv(file, file.gsub("Skeleton", name.capitalize))
    end

    if file.include?("skeleton")
        FileUtils.mv(file, file.gsub("skeleton", name[0].downcase + name[1..-1]))
    end
end


def snake_case(str)
    str.split(/(?=[A-Z])/).join("_").downcase
end


def replace_in_file(file, old_word, new_word)
    text = File.read(file)
    new_contents = text.gsub(old_word, new_word).gsub(old_word[0].upcase + old_word[1..-1], new_word[0].upcase + new_word[1..-1])
    new_file = file.gsub(old_word, new_word).gsub(old_word[0].upcase + old_word[1..-1], new_word[0].upcase + new_word[1..-1])
    File.rename(file, new_file)
    File.open(new_file, "w") { |file| file.puts new_contents }
end

def replace_in_folder(folder, old_word, new_word)
    Dir.glob("#{folder}/**/*").each do |file|
        if File.directory?(file)
            new_name = file.gsub(old_word, snake_case(new_word))
            FileUtils.mv(file, new_name) unless file == new_name
            if new_name != file
                replace_in_folder(new_name, old_word, new_word)
            end
        end
        if File.file?(file)
            replace_in_file(file, old_word, new_word)
        end
    end
end