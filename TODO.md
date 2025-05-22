# TODO

This is an example of TODO.md

View the raw content of this file to understand the format.

## Todo

- [ ] Move to python 3.13? (verify ML libs)
- [ ] Update user name
- [ ] Pass in args to Dockerfile for base images
- [ ] start to refactor for image promcessing
  - <https://dev.to/code_jedi/machine-learning-model-deployment-with-fastapi-and-docker-llo>
  - <https://medium.com/@mingc.me/deploying-pytorch-model-to-production-with-fastapi-in-cuda-supported-docker-c161cca68bb8>
- [ ] standalone classifier example - read images, and write output
  - [ ] uv.lock all ML depdencies
  - [ ] store the model statically? but using endpoint later for update?
    - [ ] perhaps it is better to just bundle the model with classifer image? and version
  - [ ] work on classifier api (multi classifier?)
  - [ ] define endpoints(update model/version)
  - [ ] get stats
  - [ ] predict
- [ ] break apart into two separate docker containers in one pod
  - [ ] ingester writer
  - [ ] classifier

### In Progress

- [ ] standalone classifier example - read images, and write output

### Done ✓

- [x] Create my first TODO.md
- [x] update project structure... need app dir, and also, modules, in src...
