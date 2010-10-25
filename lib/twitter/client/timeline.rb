module Twitter
  class Client
    module Timeline
      def public_timeline(options={})
        get('statuses/public_timeline', options)
      end

      def home_timeline(options={})
        get('statuses/home_timeline', options)
      end

      def friends_timeline(options={})
        get('statuses/friends_timeline', options)
      end

      def user_timeline(user, options={})
        merge_user_into_options!(user, options)
        get('statuses/user_timeline', options)
      end

      def mentions(options={})
        get('statuses/mentions', options)
      end

      def retweeted_by_me(options={})
        get('statuses/retweeted_by_me', options)
      end

      def retweeted_to_me(options={})
        get('statuses/retweeted_to_me', options)
      end

      def retweets_of_me(options={})
        get('statuses/retweets_of_me', options)
      end
    end
  end
end