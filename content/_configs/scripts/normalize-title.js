function normalize(str) {
  return str
    .replace(/([a-z])([A-Z])/g, '$1 $2')
    .replace(/_/g, ' ')
    .replace(/-/g, ' ')
    .replace(/\b\w/g, c => c.toUpperCase())
    .trim();
}

module.exports = async (tp) => {
  const fmTitle = tp.frontmatter?.title;
  const slug = tp.file.title;
  const display = fmTitle ? normalize(fmTitle) : normalize(slug);

  setTimeout(() => {
    const el = document.querySelector('.inline-title');
    if (el && el.textContent !== display) el.textContent = display;
  }, 100);
};
