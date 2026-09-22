---
_type: ExperienceResource
_label: "OneDrive/MS Graph: Addressing DriveItems"
experience: fref("software-engineering/experiences/file-system-on-the-web/index.td")
url: "https://learn.microsoft.com/en-us/graph/onedrive-addressing-driveitems"
kind: 'article'
tags:
  - 'api'
---

MS Graph is Microsoft's unified REST API (`graph.microsoft.com`) that consolidates access to all Microsoft 365 services (OneDrive, Outlook, Teams, SharePoint, etc.) behind one endpoint and auth model.

This document covers how OneDrive addresses files and folders through MS Graph.

MS Graph supports both ID-based and path-based addressing, relevant to our filesystem API design.

> Remark: We intend to do something similar in our cloud: A file can reference another via cloud id or path.

## Two addressing modes

### ID-based

Items get a unique ID at creation time. The ID is stable across renames and moves.

```
/drive/items/{item-id}/content
/drives/{drive-id}/items/{item-id}/content
```

- The URL structure is standard REST: `/items/` segment followed by the opaque ID.
- Stable: Renaming or moving the item does not change the ID.
- Good for internal references and bookmarks.

### Path-based

Address items by their path in the folder hierarchy, relative to any item.

```
/drive/root:/Documents/MyFile.xlsx:/content
```

The `:/` colons are delimiters that embed a filesystem path inside the REST URL:

```
/drive/root :/ Documents/MyFile.xlsx :/ content
            ^^                       ^^
            start of path            end of path
```

Everything between the two `:/` is a filesystem path. Everything outside is normal REST segments.

- The anchor can be any item, not just root:
  - `/drive/root:/path:/content` - Relative to drive root.
  - `/drive/special/documents:/path:/content` - Relative to a "special folder". `special/{name}` is a built-in shortcut to well-known folders (e.g. `documents`, `photos`), so `/drive/root:/Documents/MyFile.xlsx:/content` and `/drive/special/documents:/MyFile.xlsx:/content` resolve to the same file.
  - `/drive/items/{folder-id}:/path:/content` - Relative to any folder by ID (hybrid of both modes).
- Breaks when the item is renamed or moved (path changes).

## Path encoding

Paths are user-specified content, so they need percent encoding per RFC 3986.

### Reserved characters

These cannot appear in OneDrive file/folder names:

```
onedrive-reserved          = "/" / "\" / "*" / "<" / ">" / "?" / ":" / "|"
onedrive-business-reserved = "/" / "\" / "*" / "<" / ">" / "?" / ":" / "|" / "#" / "%"
```

- Folder names cannot end with `.`.
- Names cannot begin with `~`.

### URI path characters

Allowed characters in MS Graph URL path segments (per RFC 3986):

```
pchar       = unreserved / pct-encoded / sub-delims / ":" / "@"
unreserved  = ALPHA / DIGIT / "-" / "." / "_" / "~"
sub-delims  = "!" / "$" / "&" / "'" / "(" / ")" / "*" / "+" / "," / ";" / "="
```

Characters not in `pchar` (e.g. `#`, space) must be percent-encoded (`#` -> `%23`, ` ` -> `%20`).

### Key gotcha: Per-segment encoding

Encode each path segment individually, not the entire URL. Encoding rules differ per URL segment, so encoding the whole string makes delimiters and content ambiguous.

```
// Wrong: encodes the whole URL including delimiters
string url = url_encode("https://graph.microsoft.com/v1.0/me/drive/root:/" + path + ":/children")

// Right: encode only the user path segment
string url = "https://graph.microsoft.com/v1.0/me/drive/root:/" + url_path_encode(path) + ":/children"
```

::: warning
Not all URL encoding libraries handle path encoding correctly. E.g. .NET's `HttpUtility.UrlPathEncode` does not encode all reserved characters. Use `UriBuilder` instead.
:::
