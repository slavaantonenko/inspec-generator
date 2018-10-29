require 'chefspec'

describe 'package::remove' do
  let(:chef_run) { ChefSpec::ServerRunner.new(platform: 'ubuntu', version: '16.04').converge(described_recipe) }

  it 'removes a package with an explicit action' do
    expect(chef_run).to remove_package('explicit_action')
    expect(chef_run).to_not remove_package('not_explicit_action')
  end

  it 'removes a package with attributes' do
    expect(chef_run).to remove_package('with_attributes').with(version: '1.0.0')
    expect(chef_run).to_not remove_package('with_attributes').with(version: '1.2.3')
  end

  it 'removes a package when specifying the identity attribute' do
    expect(chef_run).to remove_package('identity_attribute')
  end

  it 'removes all packages when given an array of names' do
    expect(chef_run).to remove_package(%w(with array))
  end
end
