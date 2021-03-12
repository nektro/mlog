---
title: "Self-Hosting milesmcc/shynet Analytics"
date: 2021-03-11T22:14:51-08:00
---

First,

```yml
services:
  analytics:
    image: milesmcc/shynet
    ports:
      - "8080"
    environment:
      DB_NAME: shynet_analytics
      DB_USER: postgres
      DB_PASSWORD: ${POSTGRES_PASSWORD}
      DB_HOST: postgres
      DB_PORT: "5432"
      ACCOUNT_EMAIL_VERIFICATION: none
      TIME_ZONE: America/Los_Angeles
```

Then,

- `docker-compose exec analytics ./manage.py registeradmin hi@my.domain.com`
    - This will print the password to the console.
    - More users can be added by visiting `https://example.com/admin/core/user/add/` or adding `ACCOUNT_SIGNUPS_ENABLED: False`

- `docker-compose exec analytics ./manage.py hostname analytics.example.com`

- `docker-compose exec analytics ./manage.py whitelabel "My Shynet Analytics"`
