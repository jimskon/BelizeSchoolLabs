const words = ['blue', 'tree', 'cat', 'storm', 'river', 'mountain', 'ocean'];

function generateMnemonicPassword() {
  return Array.from({ length: 3 }, () =>
    words[Math.floor(Math.random() * words.length)]
  ).join('-');
}

module.exports = { generateMnemonicPassword };
