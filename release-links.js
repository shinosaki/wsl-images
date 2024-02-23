const suites = ['focal', 'jammy', 'lunar', 'mantic', 'noble']
const archs = ['amd64', 'arm64']

const date = '240223'
const url = 'https://github.com/shinosaki/wsl-images/releases/download'

const result = suites.map(suite => {
  return archs.map(arch => {
    const title = (arch === 'amd64') ? 'x64' : 'arm64'
    const path = `ubuntu-${suite}-${date}/ubuntu-${suite}-${arch}-20${date}`
    return [
      `[${title}](${url}/${path}.tar.gz)`,
      `[${title} Preconf](${url}/${path}-preconf.tar.gz)`,
    ].join(', ')
  }).join(', ')
}).join('\n')

console.log(result)