FROM mcr.microsoft.com/playwright:v1.14.1-focal

WORKDIR /playwright_tests

COPY /package.json .
COPY /package-lock.json .

COPY . ./

RUN npm install

CMD ["npx", "playwright", "test"]
