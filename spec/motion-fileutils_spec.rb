describe "Motion::FileUtils" do


  before do
    @path = "abc".cache
    @sub_path = "abc/def".cache
  end
  
  after do
    Motion::FileUtils.rm @path
    Motion::FileUtils.rm @sub_path
  end

  describe "mkdir" do
  
    it "should create a directory" do
      Motion::FileUtils.mkdir @path
      @path.exists?.should == true
    end
    
    it "should not create a directory" do
      Motion::FileUtils.mkdir @sub_path
      @sub_path.exists?.should == false
    end
    
  end
  
  describe "mkdir_p" do
  
    it "should create a directory" do
      r = Motion::FileUtils.mkdir_p @path
      r.should == @path
      @path.exists?.should == true
    end
    
    it "should create a directory" do
      r = Motion::FileUtils.mkdir_p @sub_path
      r.should == @sub_path
      @sub_path.exists?.should == true
    end
    
    it "should create a directory" do
      r = Motion::FileUtils.mkdir_p [@path, @sub_path]
      r.should == [@path, @sub_path]
      @path.exists?.should == true
      @sub_path.exists?.should == true
    end
    
    it "should create a directory using mkpath" do
      Motion::FileUtils.mkpath @path
      @path.exists?.should == true
    end
    
    it "should create a directory using makedirs" do
      Motion::FileUtils.makedirs @path
      @path.exists?.should == true
    end
    
  end
  
  
  describe "rm" do
  
    it "should remove a directory" do
      Motion::FileUtils.mkdir @path
      Motion::FileUtils.rm @path
      @path.exists?.should == false
    end

    it "should remove a directory" do
      Motion::FileUtils.mkdir @path
      Motion::FileUtils.remove @path
      @path.exists?.should == false
    end
  
  end
  
  describe "touch" do
  
    after do
      Motion::FileUtils.rm "foo".cache
    end
  
    it "should be created" do
      path = "foo".cache
      Motion::FileUtils.touch path
      File.exists?(path).should == true
      File.directory?(path).should == false
    end

  end
  
  describe "mv" do
  
    before do
      File.open("foo".cache, "w") do |f|
        f.write("foo")
      end
    end
    
    after do
      Motion::FileUtils.rm "foo".cache
      Motion::FileUtils.rm "bar".cache
      Motion::FileUtils.rm "baz".cache
    end
    
    it "should be moved to 'bar'" do
      Motion::FileUtils.mv "foo".cache, "bar".cache
      File.exists?("foo".cache).should == false
      File.exists?("bar".cache).should == true
    end
    
    it "should be overwrite to 'bar' if it exists." do
      File.open("bar".cache, "w") do |f|
        f.write("bar")
      end
      Motion::FileUtils.mv "foo".cache, "bar".cache
      File.read("bar".cache).should == "foo"
      File.exists?("foo".cache).should == false
    end
    
    it "should be move multi files if distination is directory." do
      Motion::FileUtils.touch "bar".cache
      Motion::FileUtils.mkdir "baz".cache
      
      Motion::FileUtils.mv ["foo".cache, "bar".cache], "baz".cache
      File.exists?("baz/foo".cache).should == true
      File.exists?("baz/bar".cache).should == true
    end
    
    it "should raise Errno::ENOTDIR if distination is file." do
      Motion::FileUtils.touch "bar".cache
      Motion::FileUtils.touch "baz".cache
      
      should.raise(Errno::ENOTDIR) { Motion::FileUtils.mv ["foo".cache, "bar".cache], "baz".cache }
    end
    
    it "should be moved to 'bar'" do
      Motion::FileUtils.move "foo".cache, "bar".cache
      File.exists?("foo".cache).should == false
      File.exists?("bar".cache).should == true
    end
    
  end
  
end



class NSString
  def cache
    NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, true)[0].stringByAppendingPathComponent(self)
  end
  def exists?
    NSFileManager.defaultManager.fileExistsAtPath(self)
  end

end