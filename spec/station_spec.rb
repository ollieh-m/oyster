require 'station'

describe Station do

  subject(:station) {described_class.new(:name,:zone)}

  it {is_expected.to respond_to(:zone)}

  it {is_expected.to respond_to(:name)}

end