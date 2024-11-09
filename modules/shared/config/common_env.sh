# Use corepack for js package management

yarn() {
    corepack yarn "$@"
}

yarnpkg() {
    corepack yarnpkg "$@"
}

pnpm() {
    corepack pnpm "$@"
}

pnpx() {
    corepack pnpx "$@"
}

npm() {
    corepack npm "$@"
}

npx() {
    corepack npx "$@"
}