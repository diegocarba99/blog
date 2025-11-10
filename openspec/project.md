# Project Context

## Purpose
This project is a personal blog created with Hugo. The main goal is to have a space to share ideas, tutorials, and thoughts on various topics, with a focus on technology and AI.

## Tech Stack
- **Static Site Generator**: [Hugo](https://gohugo.io/)
- **Theme**: [archie](https://github.com/athul/archie)
- **Hosting**: AWS S3 with CloudFront for content delivery.
- **Deployment**: Manual deployment using `hugo deploy` command, which syncs the `public/` directory to an S3 bucket.

## Project Conventions

### Code Style
- **Markdown**: Standard Markdown for content creation.
- **Front Matter**: YAML or TOML for metadata in content files.
- **File Naming**: Content files are named using the format `YYYY-MM-DD-title-of-the-post.md`.

### Architecture Patterns
- **Content-driven**: The site is structured around content, with posts, pages, and galleries.
- **Headless-like deployment**: The site is built locally and the output is deployed to a static hosting service.

### Testing Strategy
- **Local Verification**: Before deploying, the site is reviewed locally using `hugo server`.
- **No automated testing**: Currently, there are no automated tests in place.

### Git Workflow
- **Main branch**: All changes are committed directly to the `main` branch.
- **Commit Messages**: Commits should be descriptive of the changes made.

## Domain Context
The blog covers a range of topics, including but not limited to:
- Artificial Intelligence
- Software Development
- Technology trends
- Personal projects and experiences

## Important Constraints
- **Static Site**: The entire site is static, which means no server-side processing or databases are used on the live site.
- **Dependency on Hugo**: The project relies on Hugo and its ecosystem. Any changes must be compatible with Hugo's build process.

## External Dependencies
- **AWS**: The site is hosted on AWS, so any changes to the deployment process must be compatible with S3 and CloudFront.
- **Hugo Themes**: The site uses the `archie` theme, which is an external dependency.

