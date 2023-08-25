char *
tagicon(Monitor *m, int tag)
{
	Client *c;
	int tagindex = tag + NUMTAGS * m->num;
	if (tagindex >= LENGTH(tagicons[DEFAULT_TAGS]))
		tagindex = tagindex % LENGTH(tagicons[DEFAULT_TAGS]);
	for (c = m->clients; c && (!(c->tags & 1 << tag) || HIDDEN(c)); c = c->next);
	if (c)
		return tagicons[ALT_TAGS_DECORATION][tagindex];
	return tagicons[DEFAULT_TAGS][tagindex];
}

