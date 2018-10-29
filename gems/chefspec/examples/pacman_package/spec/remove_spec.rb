require 'chefspec'

describe 'pacman_package::remove' do
  let(:chef_run) do
    ChefSpec::ServerRunner.new(platform: 'arch', version: '4.9.11-1-ARCH')
                          .converge(described_recipe)
  end

  it 'removes a pacman_package with an explicit action' do
    expect(chef_run).to remove_pacman_package('explicit_action')
    expect(chef_run).to_not remove_pacman_package('not_explicit_action')
  end

  it 'removes a pacman_package with attributes' do
    expect(chef_run).to remove_pacman_package('with_attributes').with(version: '1.0.0')
    expect(chef_run).to_not remove_pacman_package('with_attributes').with(version: '1.2.3')
  end

  it 'removes a pacman_package when specifying the identity attribute' do
    expect(chef_run).to remove_pacman_package('identity_attribute')
  end
end
