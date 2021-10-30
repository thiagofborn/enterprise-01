# Enterprise Landing Zone

## First step 

1. After cloning the repo create a new repo.

>Removing the past:

```
rm -rf .git
```

2. Creating a new GitHub repo

Got to your GitHub account and create a new repo.

```
echo "# enterprise-01" >> README.md
git init
git add README.md
git commit -m "first commit"
git branch -M main
git remote add origin https://github.com/thiagofborn/enterprise-01.git
git push -u origin main
```