module.exports = {
  moduleFileExtensions: [
    'js',
    'jsx'
  ],
  moduleDirectories: ['node_modules'],
  moduleNameMapper: {
    '\\.(jpg|jpeg|png|gif|eot|otf|webp|svg|ttf|woff|woff2|mp4|webm|wav|mp3|m4a|aac|oga)$': '<rootDir>/spec/__mocks__/fileMock.js',
    '\\.(css|less)$': '<rootDir>/spec/__mocks__/styleMock.js'
  },
  setupTestFrameworkScriptFile: '<rootDir>/node_modules/jest-enzyme/lib/index.js',
  setupFiles: [
    '<rootDir>/spec/shims.js',
    '<rootDir>/spec/index.js'
  ],
  snapshotSerializers: ['enzyme-to-json/serializer']
}

