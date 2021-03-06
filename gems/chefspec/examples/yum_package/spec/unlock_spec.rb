require 'chefspec'

describe 'yum_package::unlock' do
  let(:chef_run) do
    ChefSpec::ServerRunner.new(platform: 'centos', version: '7.3.1611')
                          .converge(described_recipe)
  end

  it 'unlocks a yum_package with an explicit action' do
    expect(chef_run).to unlock_yum_package('explicit_action')
    expect(chef_run).to_not unlock_yum_package('not_explicit_action')
  end

  it 'unlocks a yum_package with attributes' do
    expect(chef_run).to unlock_yum_package('with_attributes').with(version: '1.0.0')
    expect(chef_run).to_not unlock_yum_package('with_attributes').with(version: '1.2.3')
  end

  it 'unlocks a yum_package when specifying the identity attribute' do
    expect(chef_run).to unlock_yum_package('identity_attribute')
  end
end
