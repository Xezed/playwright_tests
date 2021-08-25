FROM mcr.microsoft.com/playwright:focal

WORKDIR /sanity-checks

COPY /package.json .
RUN npm install

COPY . ./

CMD ["npm", "test"]
