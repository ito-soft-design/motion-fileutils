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
  
end



class NSString
  def cache
    NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, true)[0].stringByAppendingPathComponent(self)
  end
  def exists?
    NSFileManager.defaultManager.fileExistsAtPath(self)
  end

end