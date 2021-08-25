FROM mcr.microsoft.com/playwright:v1.14.1-focal

WORKDIR /sanity-checks

COPY /package.json .
COPY /package-lock.json .

COPY . ./

CMD ["npx", "playwright", "test"]
