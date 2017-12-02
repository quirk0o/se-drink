import PropTypes from 'prop-types'

export const Question = PropTypes.shape({
  id: PropTypes.arrayOf(PropTypes.string).isRequired,
  slug: PropTypes.string.isRequired,
  text: PropTypes.string.isRequired
})
