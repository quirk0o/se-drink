const API_URL = `http://localhost:8090/api`

const CONSULT_URL = `${API_URL}/drink/consult`
const ANSWER_URL = `${API_URL}/drink/answer`
const CLEAR_URL = `${API_URL}/drink/clear`

const answerReady = () => Math.random() <= 0.2

let i = 0
const questions = [
  ['weather', 'warm'],
  ['stress', 'high'],
  ['tiredness', 'high'],
  ['like', 'coffee'],
  ['allergy', 'lactose']
]

const questionToString = (question) => {
  if (question[0] === 'like') {
    return `Do you like ${question[1]}?`
  }
  if (['stress', 'tiredness', 'stomach_ache', 'company'].includes(question[0])) {
    return `Is your ${question[0].split('_').join(' ')} ${question[1]}?`
  }
  if (['weather'].includes(question[0])) {
    return `Is the ${question[0]} ${question[1]}?`
  }
  if (['allergy'].includes(question[0])) {
    return `Are you allergic to ${question[1]}?`
  }

  return `${question[0].charAt(0).toUpperCase()}${question[0].slice(1)} ${question[1]}?`
}

const transformQuestion = (question) => ({
  id: question,
  text: questionToString(question),
  slug: question.join('_')
})

const answer = 'Latte'

const QuestionService = {
  consult () {
    // return Promise.resolve(answerReady() || i >= questions.length
    //   ? {type: 'drink', drinkName: answer}
    //   : {type: 'question', question: transformQuestion(questions[i++])}
    // )
    return fetch(CONSULT_URL)
      .then((response) => response.json())
      .then((body) => {
        if (body.type === 'question') {
          body.question = transformQuestion(body.question)
        }
        return body
      })
  },

  answer (question, answer) {
    // return Promise.resolve('ok')
    return fetch(ANSWER_URL, {
      method: 'POST',
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json'
      },
      body: JSON.stringify({question, answer})
    })
      .then((response) => response.json())
  },

  clear () {
    // i = 0
    return fetch(CLEAR_URL)
  }
}

export default QuestionService
