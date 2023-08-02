import 'package:flutter/material.dart';
import 'package:newsapp/web_viewer/web_view.dart';



class NewsContainer extends StatelessWidget {
  NewsContainer({

    required this.article,
  });
  Map<String, dynamic> article;

  @override
  Widget build(BuildContext context) {


    return InkWell(
      onTap: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => Web(article['url'])));
      },
      child: Container(
        width: 350,
        height: 150,
        child: Row(
          children: [
            article['urlToImage'] != null
                ? Expanded(
                  child: Image.network(
              '${article['urlToImage']}', // Use the imageUrl obtained from the API here
              width: 145,
              height: 130,
              fit: BoxFit.cover,
            ),
                )
                : const Placeholder( // Placeholder widget will be shown if imageUrl is null
              fallbackHeight: 120,
              fallbackWidth: 120,
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: Text(
                      ' ${article['title']}',
                      style: Theme.of(context).textTheme.titleLarge,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 5,
                    ),
                  ),
                  Text(
                    '${article['publishedAt']}',
                    style:  Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
class DefaultDivider extends StatelessWidget {
  const DefaultDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: ThemeData.dark != null? Colors.white60 : Colors.black45,
      thickness: 1,
    );
  }
}