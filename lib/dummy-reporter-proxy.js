// Dummy metrics reporter
//
// This is an inert interface for metrics reporter. Metrics reporter is a
// required dependency of the part of fuzzy-finder that we use, but we don't
// want to pollute fuzzy-finder by sending metrics from this plugin.
//
// See proxy used in fuzzy-finder:
//
//   https://github.com/atom/fuzzy-finder/blob/master/lib/reporter-proxy.js
//
// Here we're using an actual ES Proxy. Maybe that will protect us against
// future evolutions in the fuzzy-finder package.

const noop = () => {}

module.exports = new Proxy({}, {
  get() {
    return noop
  },
})
