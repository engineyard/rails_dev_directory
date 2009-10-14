require File.join(File.dirname(__FILE__), 'helper')

context "An ActiveRecord instance acting as textiled" do
  specify "should return nil for empty fields" do
    story = Story.new

    story.description.should.be.nil
    story.description_source.should.be.nil
    story.description_plain.should.be.nil
  end

  specify "should enhance attributes with html, textile, and plain versions" do
    story = Story.find(1)

    desc_html    = '_why announces <i>Sandbox</i>'
    desc_textile = '_why announces __Sandbox__'
    desc_plain   = '_why announces Sandbox'

    story.description.should.equal desc_html
    story.description(:source).should.equal desc_textile
    story.description(:plain).should.equal desc_plain

    story.description_source.should.equal desc_textile
    story.description_plain.should.equal desc_plain

    # make sure we don't overwrite anything - thanks James
    story.description.should.equal desc_html
    story.description(:source).should.equal desc_textile
    story.description(:plain).should.equal desc_plain

    story.description_source.should.equal desc_textile
    story.description_plain.should.equal desc_plain
  end

  specify "should raise when given a non-sensical option" do
    story = Story.find(1)

    proc { story.description(:cassadaga) }.should.raise
  end

  specify "should pick up changes to attributes" do
    story = Story.find(2)
    
    start_html = '<i>Beautify</i> your <strong>IRb</strong> prompt'
    story.description.should.equal start_html 

    story.description = "**IRb** is simple"
    changed_html = "<b>IRb</b> is simple"
    story.description.should.equal changed_html

    story.save

    story.description.should.equal changed_html 
    story.description_plain.should.equal 'IRb is simple' 
  end

  specify "should be able to toggle whether textile is active or not" do
    story = Story.find(2)
    
    desc_html    = '<i>Beautify</i> your <strong>IRb</strong> prompt'
    desc_textile = '__Beautify__ your *IRb* prompt'

    story.description.should.equal desc_html
    story.textiled = false
    story.description.should.equal desc_textile 

    story.save

    story.description.should.equal desc_textile 
    story.textiled = true
    story.description.should.equal desc_html
  end

  specify "should textile attributes across associations" do
    story = Story.find(2)

    blog_html    = '<a href="http://ozmm.org">ones zeros majors and minors</a>'
    blog_textile = '"ones zeros majors and minors":http://ozmm.org'
    blog_plain   = 'ones zeros majors and minors'

    story.author.blog.should.equal blog_html 
    story.author.blog_source.should.equal blog_textile 
    story.author.blog_plain.should.equal blog_plain 
  end

  specify "should be able to toggle across associations" do
    story = Story.find(1)

    blog_html    = '<a href="http://redhanded.hobix.com">RedHanded</a>'
    blog_textile = '"RedHanded":http://redhanded.hobix.com'
    blog_plain   = 'RedHanded'

    story.author.blog.should.equal blog_html 
    story.author.textiled = false

    story.author.blog.should.equal blog_textile
    story.author.textiled = true

    story.author.blog.should.equal blog_html 
  end

  specify "should enhance text attributes" do
    story = Story.find(3)

    body_html    = %[<p><em>Textile</em> is useful because it makes text <em>slightly</em> easier to <strong>read</strong>.</p>\n\n\n\t<p>If only it were so <strong>easy</strong> to use in every programming language.  In Rails,\nwith the help of <a href="http://google.com/search?q=acts_as_textiled">acts_as_textiled</a>,\nit&#8217;s way easy.  Thanks in no small part to <span style="color:red;">RedCloth</span>, of course.</p>]
    body_textile = %[_Textile_ is useful because it makes text _slightly_ easier to *read*.\n\nIf only it were so *easy* to use in every programming language.  In Rails,\nwith the help of "acts_as_textiled":http://google.com/search?q=acts_as_textiled,\nit's way easy.  Thanks in no small part to %{color:red}RedCloth%, of course.\n]
    body_plain   = %[Textile is useful because it makes text slightly easier to read.\n\n\n\tIf only it were so easy to use in every programming language.  In Rails,\nwith the help of acts_as_textiled,\nit's way easy.  Thanks in no small part to RedCloth, of course.]

    story.body.should.equal body_html 
    story.body_source.should.equal body_textile 
    story.body_plain.should.equal body_plain
  end

  specify "should handle character conversions" do
    story = Story.find(4)

    body_html  = "<p>Is Textile&#8482; the wave of the future?  What about acts_as_textiled&#169;?  It&#8217;s\ndoubtful.  Why does Textile&#8482; smell like <em>Python</em>?  Can we do anything to\nfix that?  No?  Well, I guess there are worse smells &#8211; like Ruby.  jk.</p>\n\n\n\t<p>But seriously, ice &gt; water and water &lt; rain.  But&#8230;nevermind.  1&#215;1?  1.</p>\n\n\n\t<p>&#8220;You&#8217;re a good kid,&#8221; he said.  &#8220;Keep it up.&#8221;</p>"
    body_plain = %[Is Textile(TM) the wave of the future?  What about acts_as_textiled(C)?  It's\ndoubtful.  Why does Textile(TM) smell like Python?  Can we do anything to\nfix that?  No?  Well, I guess there are worse smells-like Ruby.  jk.\n\n\n\tBut seriously, ice > water and water < rain.  But...nevermind.  1x1?  1.\n\n\n\t"You're a good kid," he said.  "Keep it up."]

    story.body.should.equal body_html 
    story.body_plain.should.equal body_plain 
  end

  specify "should be able to do on-demand textile caching" do
    story = Story.find(1)

    desc_html = '_why announces <i>Sandbox</i>'

    story.textiled.size.should.equal 0

    story.textilize

    story.textiled.size.should.equal 2
    story.description.should.equal desc_html 
  end

  specify "should work well with after_find callbacks" do
    story = StoryWithAfterFind.find(2)

    desc_html = '<i>Beautify</i> your <strong>IRb</strong> prompt'

    story.textiled.size.should.equal 2 
    story.description.should.equal desc_html
  end
end
