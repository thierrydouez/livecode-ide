# Community Documentation Contributions

Have you noticed an error in the documentation? Do you want to add an instructive example? 
Or can you explain a concept better than it is currently explained? Please consider submitting
your proposed changes directly to the livecode repo on GitHub.

After creating an account on GitHub at https://github.com/join, there are three main ways 
of submitting pull requests. The first exclusively uses the GitHub website, and is most suitable
for people with no experience of git or other version control systems.

## Using the GitHub Web Interface

Here is the dictionary directory on the community-docs branch.
https://github.com/runrev/livecode/blob/community-docs/docs/dictionary/

Navigate to the file you want to modify, for example, the accept command:

https://github.com/runrev/livecode/blob/community-docs/docs/dictionary/command/accept.lcdoc

Click the pencil icon to the right of Raw|Blame|History buttons

Make your changes

In the Propose file change section, enter the title and description of your pull request.

The title should be along the lines of 

`[[ Community Docs ]] <short description of what was fixed / updated>`

for example:

`[[ Community Docs ]] Added working example to dictionary entry for accept command`

or

`[[ Community Docs ]] Ensure parameter names match those in syntax in dictionary entry for prepare command`


The description field is only necessary if you have made any more major changes to a file.

For example your title might be

`[[ Community Docs ]] Rewrite various parts of dictionary entry for revXMLDeleteTree command`

and description

`
- Moved some information pertaining to *the result* into the result section
- Added details about how to use command to description
- Added working example illustrating how to use command
`

Then click the Propose File Change button.

Click Create Pull Request, and it will show you the title and description you entered before.
Click Create Pull Request again.

You should now be able to see your pull request here
https://github.com/runrev/livecode/pulls

Click on the pull request link.
If you have not signed the Contributor's Agreement, livecode-vulcan will have commented (or will soon!)
to ask you to do so. 


If you are not fixing a particular bug in the bug database, that is all you need to do.
Otherwise, you need to add a release note describing what bug you have fixed.

Click on the link to your github user name on the pull request (or go to https://github.com/<user name>)

Click on the link to your livecode repository (under the Popular Repositories heading)

You should see a link to your recently pushed branch (called patch-1 or similar)

Click on that, and navigate using the folder listing to docs/notes

At the top of the page you should see something like

Branch: patch-1   livecode/docs/notes/ +

Click on the +

Name the file `bugfix-<bug number>.md`

and in the file contents, put the single line

`# <Description of bug fixed>`

In the Commit new file section add

Add release note

or something similar.

Click the "Commit new file" button.

Check the pull request again in 
https://github.com/runrev/livecode/pulls

You should see the "Add release note" commit added to the pull request.

## Using Git GUI software

Download a Git GUI Client from 
http://git-scm.com/downloads/guis

Once you have familiarised yourself with the client, go to the livecode repo
https://github.com/runrev/livecode
and click Fork, and then "Clone in Desktop" button at the top right.
clone to a suitable location.

Click the branch button
name it something suitable

Modify what you want to change

You should see the change appear in the GUI client.

If you are fixing a particular bug in the bug database, you need to add a release note 
describing what bug you have fixed.

Add a new file to docs/notes locally, named `bugfix-<bug number>.md`, containing the single line

`# <Description of bug fixed>`

Make sure both the docs change and the bugfix note are ready for commit in the GUI client.

In the summary and description section,

The title should be along the lines of 

`[[ Community Docs ]] <short description of what was fixed / updated>`

for example:

`[[ Community Docs ]] Added working example to dictionary entry for accept command`

or

`[[ Community Docs ]] Ensure parameter names match those in syntax in dictionary entry for prepare command`


The description field is only necessary if you have made any more major changes to a file.

For example your title might be

`[[ Community Docs ]] Rewrite various parts of dictionary entry for revXMLDeleteTree command`

and description

`
- Moved some information pertaining to *the result* into the result section
- Added details about how to use command to description
- Added working example illustrating how to use command
`

Click commit to <branch>

Then click "Submit pull request"

Make sure the target branch is runrev/community-docs

Check the pull request has appeared in
https://github.com/runrev/livecode/pulls

## Command Line

go to the livecode repo
https://github.com/runrev/livecode
and click Fork

then in a terminal window, in a suitable directory, run

`git clone --recursive https://github.com/<your user name>/livecode.git`

once this is done, add the livecode repo as upstream

`git remote add upstream https://github.com/runrev/livecode.git`

checkout the `community-docs` branch

`git checkout community-docs`

ensure it is up to date

`git pull upstream community-docs`

create a new branch for your docs changes, for example

`git checkout -b docs-accept_command`

make your changes to the file you are changing, then add the changes to the staging area

`git add docs/dictionary/command/accept.lcdoc`

If you are fixing a particular bug in the bug database, you need to add a release note 
describing what bug you have fixed.

Add a new file to docs/notes locally, named `bugfix-<bug number>.md`, containing the single line

`# <Description of bug fixed>`

and add that to the staging area too

`git add docs/notes/bugfix-10000.md`

Then commit your changes

`git commit -m "[[ Community Docs ]] <short description of what was fixed / updated>"`

for example:

`git commit -m "[[ Community Docs ]] Added working example to dictionary entry for accept command"`

Push the changes to your fork of the repo

`git push`

Navigate to your fork on the Git website, https://github.com/<user name>/livecode/

You should see a link to the recently pushed branch, and an invitation to submit a pull request.
Click this. 

Ensure the base fork is runrev/livecode, and the base is community-docs.

Click create pull request.

Check the pull request has appeared in
https://github.com/runrev/livecode/pulls
