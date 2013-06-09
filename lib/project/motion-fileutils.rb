module Motion
  module FileUtils
    
    def self.private_module_function(name)   #:nodoc:
      module_function name
      private_class_method name
    end
  
    def mkdir(dir, options = {})
      mkdir_with_intermediate(dir, false, options)
    end
    module_function :mkdir
  
    def mkdir_p(dir, options = {})
      mkdir_with_intermediate(dir, true, options)
    end
    module_function :mkdir_p
  
    alias :mkpath :mkdir_p
    module_function :mkpath
  
    alias :makedirs :mkdir_p
    module_function :makedirs
  
    def rm(list, options = {})
      error = Pointer.new(:object)
      m = NSFileManager.defaultManager
      list = [list] unless list.is_a? Array
      list.each do |path|
        r = m.removeItemAtPath path, error:error
#p error, r unless r
      end
    end
    module_function :rm
  
    alias :remove :rm
    module_function :remove
  
    private
  
    def mkdir_with_intermediate(dir, intermediate, options = {})
      error = Pointer.new(:object)
      m = NSFileManager.defaultManager
      dir = [dir] unless dir.is_a? Array
      paths = []
      dir.each do |path|
        r = m.createDirectoryAtPath path, withIntermediateDirectories:intermediate, attributes:nil, error:error
        paths << path if r
#p error, r unless r
      end
      case paths.size
      when 0
        nil
      when 1
        paths.first
      else
        paths
      end
    end
    private_module_function :mkdir_with_intermediate
  
  
    def touch(list, options = {})
      t = options[:mtime]
      created = nocreate = options[:nocreate]
      list = [list] unless list.is_a? Array
      list.each do |path|
        begin
          File.utime(t, t, path)
        rescue Errno::ENOENT
          raise if created
          File.open(path, 'a') {
            ;
          }
          created = true
          retry if t
        end
      end
    end
    module_function :touch
  

  end
end
