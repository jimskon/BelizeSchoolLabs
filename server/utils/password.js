const fs = require('fs');
const path = require('path');

// Load 5-letter words
const words = fs.readFileSync(path.join(__dirname, 'wordlist-5.txt'), 'utf-8')
  .split('\n')
  .map(w => w.trim().toLowerCase())
  .filter(w => w.length === 5);

// Capitalize first letter
function capitalize(word) {
  return word.charAt(0).toUpperCase() + word.slice(1);
}

// Generate camelCase password: e.g., appleCrispDance
function generateReadablePassword() {
  const sample = () => words[Math.floor(Math.random() * words.length)];
  const [w1, w2, w3] = [sample(), sample(), sample()];
    return capitalize(w1) + capitalize(w2) + capitalize(w3);
}

module.exports = { generateReadablePassword };
