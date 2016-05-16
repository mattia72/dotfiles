local path = require('path')

---
-- Resolves closest .git directory location.
-- Navigates subsequently up one level and tries to find .git directory
-- @param  {string} path Path to directory will be checked. If not provided
--                       current directory will be used
-- @return {string} Path to .git directory or nil if such dir not found
local function get_git_dir(start_dir)

  ---
  -- Checks if provided directory contains git directory
  -- @param {String} dir Directory where `.git` might be found
  -- @returns {String|Boolean} Returns concatenated parameter and
  --   .git directory path if it was found, false otherwise
  local function has_git_dir(dir)
    return #clink.find_dirs(dir..'/.git') > 0 and dir..'/.git'
  end

  ---
  --  Checks if provided directory contains .git file that contains
  --   relative path to submodule.
  -- @param {String} dir Directory where `.git` might be found
  -- @returns {String|Boolean} Returns concatenated parameter and
  --   resolved submodule directory path if it was found, false otherwise
  local function has_git_file(dir)
    local gitfile = io.open(dir..'/.git')
    if not gitfile then return false end

    local git_dir = gitfile:read():match('gitdir: (.*)')
    gitfile:close()

    return git_dir and dir..'/'..git_dir
  end

  -- Set default path to current directory
  if not start_dir or start_dir == '.' then start_dir = clink.get_cwd() end

  -- Calculate parent path now otherwise we won't be
  -- able to do that inside of logical operator
  local parent_path = path.pathname(start_dir)

  return has_git_dir(start_dir)
  or has_git_file(start_dir)
  -- Otherwise go up one level and make a recursive call
  or (parent_path ~= start_dir and get_git_dir(parent_path) or nil)
end

---
-- Find out current branch
-- @return {false|git branch name}
---
function get_git_branch()
  if get_git_dir(clink.get_cwd()) then
    for line in io.popen("git branch 2>nul"):lines() do
      local m = line:match("%* (.+)$")
      if m then
        return m
      end
    end
  end
  return false
end

---
-- Get the status of working dir
-- @return {bool}
---
function get_git_status()
  return os.execute("git diff --quiet --ignore-submodules HEAD")
end

function git_prompt_filter()

  -- Colors for git status
  local colors = {
    branch = "\x1b[1;36;40m" ,
    clean = "\x1b[1;37;40m",
    dirty = "\x1b[31;1m",
  }

  local branch = get_git_branch()
  if branch then
    -- Has branch => therefore it is a git folder, now figure out status
    local git_info = colors.branch.."("..branch..")"

    if not get_git_status() then
      git_info = git_info..colors.dirty.."*"
      --color = colors.clean
    --else
      --color = colors.dirty
    end


    clink.prompt.value = string.gsub(clink.prompt.value, "{git}", git_info)
    return true
  end

  -- No git present or not in git file
  clink.prompt.value = string.gsub(clink.prompt.value, "{git}", "")
  return false
end

clink.prompt.register_filter(git_prompt_filter, 50)
