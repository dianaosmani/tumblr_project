require "spec_helper"

describe "Tumblr" do
  # let(:browser) { @browser = Watir::Browser.new :chrome } 
  before :all do
  	@browser = Watir::Browser.new :chrome
  	@browser.goto "https://www.tumblr.com" 
  end
  # after { browser.close }
	

	it "should load accounts from a yaml file" do
		@account = YAML.load(File.open("./accounts.yml"))
		expect(@account["Account"].to_a.size).to eq 2
		expect(@account["Account"]["email"]).to eq "osmanidiana@gmail.com"
		#expect(@account["password"]).to eq "OSMANI007"
	end

	it "Log in to Tumblr" do
		@account = YAML.load(File.open("./accounts.yml"))

		@browser.button(id: "signup_login_button").click
		@browser.input(type: 'email').send_keys @account["Account"]["email"]
		@browser.button(id: "signup_forms_submit").click
		@browser.input(id: "signup_password").wait_until_present
		@browser.input(id: "signup_password").send_keys @account["Account"]["password"]
		@browser.button(id: "signup_forms_submit").click
		expect(@browser.goto "https://www.tumblr.com/dashboard")
	end

	it "should be able to post a text post and check that it has been posted, printing 'Success" do
      # text = "Hello! This is a Test by Diana."
      # @browser.send_keys(text)

      @browser.a(id: "new_post_label_text").when_present
      @browser.element(:id, "new_post_label_text").click
      @browser.div(class: "editor editor-plaintext").send_keys("Hello!")
			# @browser.div(class: "editor editor-plaintext").wait_until_present
      @browser.div(class: "editor editor-richtext").send_keys("This is a test by Diana.")
		    # @browser.div(class: "editor editor-richtext").wait_until_present
      @browser.button(class: "button-area create_post_button").click
      # @browser.button(class: "button-area create_post_button").wait_until_present
		    # expect(@browser.url).to eq "https://www.tumblr.com/dashboard"
	 if @browser.div(class: "post_title").text == "Hello!"
        puts "Success!"
    end
    end
end
    