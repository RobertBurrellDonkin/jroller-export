#set($entries = $pageModel.getRecentWeblogEntriesArray(100, ''))
<?xml version="1.0" encoding='utf-8'?>
<feed version="0.3" xmlns="http://purl.org/atom/ns#">
	<!-- Special Archive version of Atom, created by Roller, corrected by D. Bonvillain -->
    <title>$utilities.textToHTML($website.name,true)</title>
    <tagline>$utilities.textToHTML($website.description,true)</tagline>
    <modified>$utilities.formatIso8601Date($updateTime)</modified>

    #foreach( $entry in $entries )
    <entry xmlns="http://purl.org/atom/ns#" >
        <id>$entry.id</id>
        <title>$utilities.textToHTML($entry.title,true)</title>
        <subject>$entry.category.path</subject>

        <author>
          <name>$fullName</name>
        </author>

        <issued>$utilities.formatIso8601Date($entry.pubTime)</issued>
        <created>$utilities.formatIso8601Date($entry.pubTime)</created>
        <modified>$utilities.formatIso8601Date($entry.updateTime)</modified>

        <content><![CDATA[$entry.text]]></content>
    </entry>
        ## use "experimental" form of Comment 'annotation'
        #foreach( $comment in $entry.comments )
        <entry xmlns="http://purl.org/atom/ns#" >
            <id>$comment.id</id>
            <title>$utilities.textToHTML($utilities.truncateNicely($comment.content,40,50,"..."))</title>

            <author>
              <name>$utilities.textToHTML($comment.name, true)</name>
              <url>$utilities.textToHTML($comment.url)</url>
              <email>$comment.email</email>
            </author>
            <issued>$utilities.formatIso8601Date($comment.postTime)</issued>
            <content><![CDATA[$comment.content]]></content>
            <annotate type="comment" rel="parent">$entry.id</annotate>
        </entry>
        #end
    #end
</feed>