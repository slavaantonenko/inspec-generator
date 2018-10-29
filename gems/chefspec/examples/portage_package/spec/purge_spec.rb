require 'chefspec'

describe 'portage_package::purge' do
  let(:chef_run) do
    ChefSpec::ServerRunner.new(platform: 'gentoo', version: '2.2')
                          .converge(described_recipe)
  end

  it 'purges a portage_package with an explicit action' do
    expect(chef_run).to purge_portage_package('explicit_action')
    expect(chef_run).to_not purge_portage_package('not_explicit_action')
  end

  it 'purges a portage_package with attributes' do
    expect(chef_run).to purge_portage_package('with_attributes').with(version: '1.0.0')
    expect(chef_run).to_not purge_portage_package('with_attributes').with(version: '1.2.3')
  end

  it 'purges a portage_package when specifying the identity attribute' do
    expect(chef_run).to purge_portage_package('identity_attribute')
  end
end
