import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const AkashPortfolioApp());
}

class AkashPortfolioApp extends StatefulWidget {
  const AkashPortfolioApp({super.key});

  @override
  State<AkashPortfolioApp> createState() => _AkashPortfolioAppState();
}

class _AkashPortfolioAppState extends State<AkashPortfolioApp> {
  // Theme state: false = Executive Light (Default), true = Midnight Luxury
  bool _isDarkTheme = false;

  void _toggleTheme() {
    setState(() {
      _isDarkTheme = !_isDarkTheme;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Executive Light Palette
    final lightTheme = ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: const Color(0xFFF8FAFC),
      primaryColor: const Color(0xFF0284C7),
      colorScheme: const ColorScheme.light(
        primary: Color(0xFF0284C7),
        secondary: Color(0xFF0F172A),
        surface: Colors.white,
        onSurface: Color(0xFF0F172A),
        outline: Color(0xFFE2E8F0),
      ),
      textTheme: GoogleFonts.plusJakartaSansTextTheme(ThemeData.light().textTheme),
    );

    // Midnight Luxury Palette
    final darkTheme = ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: const Color(0xFF0D1117),
      primaryColor: const Color(0xFFE2C799),
      colorScheme: const ColorScheme.dark(
        primary: Color(0xFFE2C799),
        secondary: Color(0xFFF0F6FC),
        surface: Color(0xFF161B22),
        onSurface: Color(0xFFF0F6FC),
        outline: Color(0xFF30363D),
      ),
      textTheme: GoogleFonts.plusJakartaSansTextTheme(ThemeData.dark().textTheme),
    );

    return MaterialApp(
      title: 'Akash Gupta | Senior Flutter & Mobile Application Developer',
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: _isDarkTheme ? ThemeMode.dark : ThemeMode.light,
      home: PortfolioWebPage(
        isDarkTheme: _isDarkTheme,
        onToggleTheme: _toggleTheme,
      ),
    );
  }
}

class PortfolioWebPage extends StatefulWidget {
  final bool isDarkTheme;
  final VoidCallback onToggleTheme;

  const PortfolioWebPage({
    super.key,
    required this.isDarkTheme,
    required this.onToggleTheme,
  });

  @override
  State<PortfolioWebPage> createState() => _PortfolioWebPageState();
}

class _PortfolioWebPageState extends State<PortfolioWebPage> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _heroKey = GlobalKey();
  final GlobalKey _aboutKey = GlobalKey();
  final GlobalKey _skillsKey = GlobalKey();
  final GlobalKey _projectsKey = GlobalKey();
  final GlobalKey _experienceKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();

  String _selectedCategory = 'All';

  void _scrollToKey(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 650),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  Future<void> _openUrl(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Could not open $url')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = widget.isDarkTheme;

    final primaryColor = isDark ? const Color(0xFFE2C799) : const Color(0xFF0284C7);
    final cardBg = isDark ? const Color(0xFF161B22) : Colors.white;
    final borderColor = isDark ? const Color(0xFF30363D) : const Color(0xFFE2E8F0);
    final textMuted = isDark ? const Color(0xFF8B949E) : const Color(0xFF64748B);

    return Scaffold(
      // Dedicated Web Header (Never collapses into hamburger)
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(76),
        child: Container(
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF161B22) : Colors.white,
            border: Border(bottom: BorderSide(color: borderColor, width: 1)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(isDark ? 40 : 8),
                blurRadius: 12,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1200),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Row(
                  children: [
                    // Brand Identity
                    InkWell(
                      onTap: () => _scrollToKey(_heroKey),
                      borderRadius: BorderRadius.circular(8),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                            decoration: BoxDecoration(
                              color: isDark ? const Color(0xFF21262D) : const Color(0xFFF1F5F9),
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(color: borderColor),
                            ),
                            child: Text(
                              'AG',
                              style: GoogleFonts.jetBrainsMono(
                                fontWeight: FontWeight.w800,
                                fontSize: 14,
                                color: primaryColor,
                              ),
                            ),
                          ),
                          const SizedBox(width: 14),
                          Text(
                            'Akash Gupta',
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 19,
                              color: theme.colorScheme.onSurface,
                              letterSpacing: -0.4,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),

                    // Permanent Desktop Navigation Links
                    _buildWebNavLink('About', () => _scrollToKey(_aboutKey)),
                    _buildWebNavLink('Expertise', () => _scrollToKey(_skillsKey)),
                    _buildWebNavLink('Case Studies', () => _scrollToKey(_projectsKey)),
                    _buildWebNavLink('Career', () => _scrollToKey(_experienceKey)),
                    _buildWebNavLink('Contact', () => _scrollToKey(_contactKey)),
                    const SizedBox(width: 20),

                    // Theme Palette Switcher
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: borderColor),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: IconButton(
                        icon: Icon(
                          isDark ? Icons.light_mode_outlined : Icons.dark_mode_outlined,
                          color: primaryColor,
                          size: 20,
                        ),
                        tooltip: isDark ? 'Switch to Light Theme' : 'Switch to Dark Theme',
                        onPressed: widget.onToggleTheme,
                      ),
                    ),
                    const SizedBox(width: 14),

                    // Resume Download Action
                    ElevatedButton.icon(
                      onPressed: () => _openUrl('https://www.linkedin.com/in/akash-gupta-abb175111/'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        foregroundColor: isDark ? const Color(0xFF0D1117) : Colors.white,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      icon: const Icon(Icons.description_outlined, size: 16),
                      label: const Text('Curriculum Vitae', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            // 1. HERO SECTION (Spacious Web Presentation)
            Container(
              key: _heroKey,
              padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 90),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1140),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Status Eyebrow
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                        decoration: BoxDecoration(
                          color: isDark ? const Color(0xFF21262D) : const Color(0xFFEFF6FF),
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(
                            color: isDark ? const Color(0xFF30363D) : const Color(0xFFBFDBFE),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 8,
                              height: 8,
                              decoration: const BoxDecoration(
                                color: Color(0xFF10B981),
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              'Lead QA Analyst & Flutter Developer • Available for Select Engagements',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: isDark ? const Color(0xFFE2C799) : const Color(0xFF0369A1),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 28),

                      // Large Web Headline
                      RichText(
                        text: TextSpan(
                          style: TextStyle(
                            fontSize: 56,
                            fontWeight: FontWeight.w800,
                            letterSpacing: -1.5,
                            height: 1.15,
                            color: theme.colorScheme.onSurface,
                          ),
                          children: [
                            const TextSpan(text: 'Engineering reliable '),
                            TextSpan(
                              text: 'mobile architectures ',
                              style: GoogleFonts.instrumentSerif(
                                fontStyle: FontStyle.italic,
                                color: primaryColor,
                              ),
                            ),
                            const TextSpan(text: '& connected IoT ecosystems.'),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Intro Description
                      ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 880),
                        child: Text(
                          'I am Akash Gupta—a cross-platform mobile application developer with 4+ years of software delivery experience. '
                          'I architect, engineer, and rigorously validate production applications across Flutter, Dart, and FlutterFlow, '
                          'bridging physical hardware via Bluetooth Low Energy (BLE), Wi-Fi, and MQTT.',
                          style: TextStyle(
                            fontSize: 19,
                            height: 1.7,
                            color: textMuted,
                          ),
                        ),
                      ),
                      const SizedBox(height: 40),

                      // Primary Web Actions
                      Row(
                        children: [
                          ElevatedButton.icon(
                            onPressed: () => _scrollToKey(_projectsKey),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: primaryColor,
                              foregroundColor: isDark ? const Color(0xFF0D1117) : Colors.white,
                              padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 18),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                              elevation: 0,
                            ),
                            icon: const Icon(Icons.arrow_downward, size: 18),
                            label: const Text('Explore Case Studies', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                          ),
                          const SizedBox(width: 16),
                          OutlinedButton.icon(
                            onPressed: () => _scrollToKey(_contactKey),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: theme.colorScheme.onSurface,
                              side: BorderSide(color: borderColor, width: 1.5),
                              padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 18),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            ),
                            icon: const Icon(Icons.mail_outline, size: 18),
                            label: const Text('Initiate Conversation', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                          ),
                          const SizedBox(width: 16),
                          TextButton.icon(
                            onPressed: () => _openUrl('https://www.linkedin.com/in/akash-gupta-abb175111/'),
                            style: TextButton.styleFrom(
                              foregroundColor: textMuted,
                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                            ),
                            icon: const Icon(Icons.open_in_new, size: 18),
                            label: const Text('LinkedIn Profile', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15)),
                          ),
                        ],
                      ),
                      const SizedBox(height: 64),

                      // 4-Column Web Metrics Grid (Always Wide)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 28),
                        decoration: BoxDecoration(
                          color: cardBg,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: borderColor),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withAlpha(isDark ? 50 : 8),
                              blurRadius: 20,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Expanded(child: _buildWebMetric('4+ Years', 'Software Engineering & Mobile QA', primaryColor)),
                            _buildVerticalDivider(borderColor),
                            Expanded(child: _buildWebMetric('10+ Apps', 'Commercial & Enterprise Projects', primaryColor)),
                            _buildVerticalDivider(borderColor),
                            Expanded(child: _buildWebMetric('IoT Sync', 'BLE, Wi-Fi & MQTT Connectivity', primaryColor)),
                            _buildVerticalDivider(borderColor),
                            Expanded(child: _buildWebMetric('Full Cycle', 'Architecture to QA Deployment', primaryColor)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // 2. ABOUT SECTION (Wide 2-Column Desktop Grid)
            Container(
              key: _aboutKey,
              color: isDark ? const Color(0xFF161B22) : const Color(0xFFF1F5F9),
              padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 96),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1140),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildWebSectionTag('Overview', primaryColor, isDark),
                      const SizedBox(height: 12),
                      Text(
                        'A rigorous engineering approach to cross-platform mobile delivery.',
                        style: TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.w800,
                          letterSpacing: -0.8,
                          color: theme.colorScheme.onSurface,
                        ),
                      ),
                      const SizedBox(height: 48),

                      // Side-by-side Desktop Layout
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Narrative Left Column
                          Expanded(
                            flex: 6,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'High-performing applications demand deterministic state management, clean hardware interfaces, and proactive QA verification.',
                                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, height: 1.5),
                                ),
                                const SizedBox(height: 20),
                                Text(
                                  'Operating at the intersection of cross-platform engineering and Lead QA analysis at Dream Filler Software Solutions, '
                                  'I bring structural rigor to every application. My technical foundation spans custom Flutter engineering, '
                                  'rapid prototyping via FlutterFlow, real-time protocol integration (MQTT/WebSockets), and cloud infrastructure setup on AWS EC2 & S3.',
                                  style: TextStyle(fontSize: 16, height: 1.75, color: textMuted),
                                ),
                                const SizedBox(height: 18),
                                Text(
                                  'Prior to software engineering, my background as a Solar Project Engineer overseeing multi-megawatt infrastructure '
                                  'ingrained an uncompromising commitment to technical compliance, delivery schedules, and zero-defect deployments.',
                                  style: TextStyle(fontSize: 16, height: 1.75, color: textMuted),
                                ),
                                const SizedBox(height: 32),

                                // Pillars
                                _buildWebPillar(Icons.layers_outlined, 'Architecture First', 'Clean architecture, responsive layouts, and deterministic state management.', primaryColor, cardBg, borderColor),
                                const SizedBox(height: 16),
                                _buildWebPillar(Icons.sensors_outlined, 'Hardware & IoT Sync', 'Specialized in Bluetooth Low Energy (BLE), Wi-Fi provisioning, and real-time MQTT messaging.', primaryColor, cardBg, borderColor),
                                const SizedBox(height: 16),
                                _buildWebPillar(Icons.verified_outlined, 'QA & Production Reliability', 'Proactive functional, regression, API, and load verification ensuring flawless store releases.', primaryColor, cardBg, borderColor),
                              ],
                            ),
                          ),
                          const SizedBox(width: 48),

                          // Executive Profile Card (Right Column)
                          Expanded(
                            flex: 4,
                            child: Container(
                              padding: const EdgeInsets.all(32),
                              decoration: BoxDecoration(
                                color: cardBg,
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(color: borderColor),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withAlpha(isDark ? 50 : 8),
                                    blurRadius: 20,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 28,
                                        backgroundColor: primaryColor.withAlpha(35),
                                        child: Text('AG', style: TextStyle(fontWeight: FontWeight.bold, color: primaryColor, fontSize: 17)),
                                      ),
                                      const SizedBox(width: 16),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text('Akash Gupta', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 18, color: theme.colorScheme.onSurface)),
                                          const SizedBox(height: 2),
                                          Text('Satna, Madhya Pradesh, India', style: TextStyle(color: textMuted, fontSize: 13)),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const Divider(height: 36),
                                  _buildWebProfileRow('Current Organization', 'Dream Filler Software Solutions', theme),
                                  const SizedBox(height: 14),
                                  _buildWebProfileRow('Current Role', 'Lead QA Analyst & Flutter Developer', theme),
                                  const SizedBox(height: 14),
                                  _buildWebProfileRow('Academic Degree', 'B.E. — LNCT Jabalpur (2010–2014)', theme),
                                  const SizedBox(height: 14),
                                  _buildWebProfileRow('Specializations', 'Flutter, IoT Connectivity, Mobile QA', theme),
                                  const SizedBox(height: 14),
                                  _buildWebProfileRow('Availability', 'Open for Global Remote Engagements', theme),
                                  const SizedBox(height: 28),
                                  OutlinedButton.icon(
                                    onPressed: () => _openUrl('mailto:akashg092@gmail.com'),
                                    style: OutlinedButton.styleFrom(
                                      foregroundColor: primaryColor,
                                      side: BorderSide(color: primaryColor),
                                      minimumSize: const Size.fromHeight(48),
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                    ),
                                    icon: const Icon(Icons.send_outlined, size: 16),
                                    label: const Text('Email Directly', style: TextStyle(fontWeight: FontWeight.bold)),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // 3. TECHNICAL COMPETENCIES (2x2 Desktop Grid)
            Container(
              key: _skillsKey,
              padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 96),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1140),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildWebSectionTag('Competencies', primaryColor, isDark),
                      const SizedBox(height: 12),
                      Text(
                        'Technical acumen across the full software stack.',
                        style: TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.w800,
                          letterSpacing: -0.8,
                          color: theme.colorScheme.onSurface,
                        ),
                      ),
                      const SizedBox(height: 48),

                      // 2x2 Desktop Grid
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                _buildWebSkillCard(
                                  number: '01',
                                  title: 'Mobile & Cross-Platform',
                                  desc: 'Building responsive, fluid applications with native performance across iOS, Android, and Web platforms.',
                                  skills: ['Flutter', 'Dart', 'FlutterFlow', 'Responsive UI', 'State Management', 'Provider / Bloc', 'Flutter Web'],
                                  cardBg: cardBg,
                                  borderColor: borderColor,
                                  primaryColor: primaryColor,
                                  isDark: isDark,
                                ),
                                const SizedBox(height: 28),
                                _buildWebSkillCard(
                                  number: '03',
                                  title: 'Integrations, APIs & Data',
                                  desc: 'Connecting secure payment gateways, real-time message streams, and robust role-based access control.',
                                  skills: ['RESTful APIs', 'Payment Gateways', 'Firebase FCM', 'Real-Time WebSockets', 'GPS & Geo-Fencing', 'RBAC Security'],
                                  cardBg: cardBg,
                                  borderColor: borderColor,
                                  primaryColor: primaryColor,
                                  isDark: isDark,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 28),
                          Expanded(
                            child: Column(
                              children: [
                                _buildWebSkillCard(
                                  number: '02',
                                  title: 'IoT & Embedded Protocols',
                                  desc: 'Seamlessly syncing hardware sensors, smart devices, and edge peripherals with cross-platform mobile interfaces.',
                                  skills: ['BLE (Bluetooth Low Energy)', 'MQTT Protocols', 'Wi-Fi Provisioning', 'Smart Home (Alexa/Google)', 'RF Remote Sync', 'Offline Fallback'],
                                  cardBg: cardBg,
                                  borderColor: borderColor,
                                  primaryColor: primaryColor,
                                  isDark: isDark,
                                ),
                                const SizedBox(height: 28),
                                _buildWebSkillCard(
                                  number: '04',
                                  title: 'Cloud & Quality Assurance',
                                  desc: 'Exhaustive verification routines combined with cloud server configuration and deployment.',
                                  skills: ['AWS EC2 & S3', 'Ubuntu Linux', 'Postman API Testing', 'Functional & Regression QA', 'JIRA & Zoho', 'Agile / Scrum'],
                                  cardBg: cardBg,
                                  borderColor: borderColor,
                                  primaryColor: primaryColor,
                                  isDark: isDark,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // 4. CASE STUDIES & SELECTED WORK (2-Column Desktop Grid)
            Container(
              key: _projectsKey,
              color: isDark ? const Color(0xFF161B22) : const Color(0xFFF1F5F9),
              padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 96),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1140),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildWebSectionTag('Case Studies', primaryColor, isDark),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Featured commercial applications & IoT architectures.',
                            style: TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.w800,
                              letterSpacing: -0.8,
                              color: theme.colorScheme.onSurface,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 28),

                      // Desktop Filter Chips Bar
                      Wrap(
                        spacing: 10,
                        children: ['All', 'Flutter', 'IoT', 'FlutterFlow', 'QA & Cloud'].map((cat) {
                          final isSelected = _selectedCategory == cat;
                          return ChoiceChip(
                            label: Text(cat),
                            selected: isSelected,
                            onSelected: (val) {
                              if (val) setState(() => _selectedCategory = cat);
                            },
                            selectedColor: primaryColor,
                            labelStyle: TextStyle(
                              color: isSelected
                                  ? (isDark ? const Color(0xFF0D1117) : Colors.white)
                                  : theme.colorScheme.onSurface,
                              fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
                              fontSize: 14,
                            ),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 40),

                      // 2-Column Desktop Project Grid
                      _buildWebProjectGrid(cardBg, borderColor, primaryColor, textMuted, theme, isDark),
                    ],
                  ),
                ),
              ),
            ),

            // 5. CAREER TIMELINE (Desktop Stream)
            Container(
              key: _experienceKey,
              padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 96),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1140),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildWebSectionTag('Trajectory', primaryColor, isDark),
                      const SizedBox(height: 12),
                      Text(
                        'Professional history & engineering leadership.',
                        style: TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.w800,
                          letterSpacing: -0.8,
                          color: theme.colorScheme.onSurface,
                        ),
                      ),
                      const SizedBox(height: 48),

                      _buildWebTimelineItem(
                        period: 'Oct 2023 – Present',
                        role: 'Lead QA Analyst & Flutter Developer',
                        company: 'Dream Filler Software Solutions Pvt. Ltd. • Satna, India',
                        bullets: [
                          'Developed and delivered cross-platform client applications with Flutter, Dart, and FlutterFlow from requirements through deployment.',
                          'Implemented application integrations for payment gateways, push notifications, real-time messaging, and IoT device communication (BLE, Wi-Fi, MQTT).',
                          'Collaborated on application architecture and delivery workflows; established QA practices to identify defects prior to production release.',
                        ],
                        tags: ['Flutter', 'Dart', 'FlutterFlow', 'BLE & IoT', 'REST APIs', 'QA Leadership'],
                        cardBg: cardBg,
                        borderColor: borderColor,
                        primaryColor: primaryColor,
                        textMuted: textMuted,
                        theme: theme,
                      ),
                      const SizedBox(height: 28),

                      _buildWebTimelineItem(
                        period: 'Oct 2021 – Oct 2023',
                        role: 'Software Engineer Trainee / QA Analyst',
                        company: 'Dream Filler Software Solutions Pvt. Ltd. • Satna, India',
                        bullets: [
                          'Performed functional, integration, regression, and manual testing across mobile, web, and cloud-connected applications.',
                          'Documented test cases, defects, and root-cause findings using Zoho and JIRA; coordinated fixes with development teams.',
                          'Presented client demos and collected structured feedback to refine application user flows.',
                        ],
                        tags: ['Mobile & Web QA', 'Regression Testing', 'Postman', 'Zoho', 'JIRA', 'Client Demos'],
                        cardBg: cardBg,
                        borderColor: borderColor,
                        primaryColor: primaryColor,
                        textMuted: textMuted,
                        theme: theme,
                      ),
                      const SizedBox(height: 28),

                      _buildWebTimelineItem(
                        period: 'Aug 2014 – Aug 2021',
                        role: 'Solar Project Engineer',
                        company: 'Madhav Infra Project Ltd. • Bangalore, India',
                        bullets: [
                          'Coordinated large-scale solar infrastructure commissioning, compliance auditing, and multi-team scheduling.',
                          'Maintained zero-compromise adherence to safety, engineering regulations, and tight delivery schedules.',
                        ],
                        tags: ['Engineering Operations', 'Compliance', 'Risk Management', 'Schedule Delivery'],
                        cardBg: cardBg,
                        borderColor: borderColor,
                        primaryColor: primaryColor,
                        textMuted: textMuted,
                        theme: theme,
                      ),
                      const SizedBox(height: 40),

                      // Academic Accreditation Box
                      Container(
                        padding: const EdgeInsets.all(28),
                        decoration: BoxDecoration(
                          color: cardBg,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: borderColor),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 56,
                              height: 56,
                              decoration: BoxDecoration(
                                color: isDark ? const Color(0xFF21262D) : const Color(0xFFEFF6FF),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Icon(Icons.school_outlined, color: primaryColor, size: 30),
                            ),
                            const SizedBox(width: 24),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Bachelor of Engineering (B.E.)',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17,
                                      color: theme.colorScheme.onSurface,
                                    ),
                                  ),
                                  const SizedBox(height: 3),
                                  Text(
                                    'Lakshmi Narain College of Technology (LNCT), Jabalpur',
                                    style: TextStyle(color: textMuted, fontSize: 14),
                                  ),
                                  Text(
                                    'Graduated: 2010 – 2014 • Engineering Foundations & Systems Design',
                                    style: GoogleFonts.jetBrainsMono(fontSize: 12, color: textMuted),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // 6. CONTACT & ENGAGEMENT SECTION (Wide Desktop Cards)
            Container(
              key: _contactKey,
              color: isDark ? const Color(0xFF161B22) : const Color(0xFFF1F5F9),
              padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 96),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1140),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildWebSectionTag('Engagement', primaryColor, isDark),
                      const SizedBox(height: 12),
                      Text(
                        'Ready to discuss your next mobile initiative?',
                        style: TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.w800,
                          letterSpacing: -0.8,
                          color: theme.colorScheme.onSurface,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Connect directly via email, telephone, or LinkedIn.',
                        style: TextStyle(fontSize: 17, color: textMuted),
                      ),
                      const SizedBox(height: 48),

                      // Desktop 4-Card Contact Grid
                      Row(
                        children: [
                          Expanded(
                            child: _buildWebContactCard(
                              icon: Icons.email_outlined,
                              label: 'Direct Email',
                              value: 'akashg092@gmail.com',
                              onTap: () => _openUrl('mailto:akashg092@gmail.com'),
                              cardBg: cardBg,
                              borderColor: borderColor,
                              primaryColor: primaryColor,
                              theme: theme,
                            ),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: _buildWebContactCard(
                              icon: Icons.phone_outlined,
                              label: 'Call / WhatsApp',
                              value: '+91-8839706795',
                              onTap: () => _openUrl('tel:+918839706795'),
                              cardBg: cardBg,
                              borderColor: borderColor,
                              primaryColor: primaryColor,
                              theme: theme,
                            ),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: _buildWebContactCard(
                              icon: Icons.link_outlined,
                              label: 'LinkedIn Profile',
                              value: 'linkedin.com/in/akash-gupta-abb175111',
                              onTap: () => _openUrl('https://www.linkedin.com/in/akash-gupta-abb175111/'),
                              cardBg: cardBg,
                              borderColor: borderColor,
                              primaryColor: primaryColor,
                              theme: theme,
                            ),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: _buildWebContactCard(
                              icon: Icons.location_on_outlined,
                              label: 'Base Location',
                              value: 'Satna, MP, India',
                              onTap: () {},
                              cardBg: cardBg,
                              borderColor: borderColor,
                              primaryColor: primaryColor,
                              theme: theme,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // FOOTER (Wide Desktop Layout)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 48),
              decoration: BoxDecoration(
                border: Border(top: BorderSide(color: borderColor)),
              ),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1140),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Akash Gupta',
                            style: TextStyle(fontWeight: FontWeight.w800, fontSize: 17, color: theme.colorScheme.onSurface),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Senior Flutter Developer • IoT Integrator • Lead QA Analyst',
                            style: TextStyle(fontSize: 13, color: textMuted),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                        decoration: BoxDecoration(
                          color: isDark ? const Color(0xFF21262D) : const Color(0xFFEFF6FF),
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(color: borderColor),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const FlutterLogo(size: 16),
                            const SizedBox(width: 8),
                            Text(
                              'Pure Flutter Web Application',
                              style: GoogleFonts.jetBrainsMono(fontSize: 12, color: primaryColor, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Desktop Helper Widgets
  Widget _buildWebNavLink(String label, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: TextButton(
        onPressed: onTap,
        style: TextButton.styleFrom(
          foregroundColor: Theme.of(context).colorScheme.onSurface,
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        ),
        child: Text(label, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
      ),
    );
  }

  Widget _buildWebSectionTag(String label, Color primary, bool isDark) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF21262D) : const Color(0xFFEFF6FF),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: isDark ? const Color(0xFF30363D) : const Color(0xFFBFDBFE)),
      ),
      child: Text(
        label.toUpperCase(),
        style: GoogleFonts.jetBrainsMono(
          fontSize: 11,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.2,
          color: primary,
        ),
      ),
    );
  }

  Widget _buildWebMetric(String value, String label, Color primary) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          value,
          style: GoogleFonts.jetBrainsMono(
            fontSize: 28,
            fontWeight: FontWeight.w800,
            color: primary,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

  Widget _buildVerticalDivider(Color color) {
    return Container(
      width: 1,
      height: 48,
      color: color,
      margin: const EdgeInsets.symmetric(horizontal: 24),
    );
  }

  Widget _buildWebPillar(IconData icon, String title, String desc, Color primary, Color cardBg, Color borderColor) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: borderColor),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: primary.withAlpha(30),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: primary, size: 22),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 3),
                Text(desc, style: const TextStyle(fontSize: 13.5, height: 1.5, color: Color(0xFF64748B))),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWebProfileRow(String label, String value, ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label.toUpperCase(), style: GoogleFonts.jetBrainsMono(fontSize: 10, color: const Color(0xFF94A3B8), fontWeight: FontWeight.bold)),
        const SizedBox(height: 2),
        Text(value, style: TextStyle(fontSize: 13.5, fontWeight: FontWeight.w600, color: theme.colorScheme.onSurface)),
      ],
    );
  }

  Widget _buildWebSkillCard({
    required String number,
    required String title,
    required String desc,
    required List<String> skills,
    required Color cardBg,
    required Color borderColor,
    required Color primaryColor,
    required bool isDark,
  }) {
    return Container(
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              Text(number, style: GoogleFonts.jetBrainsMono(fontWeight: FontWeight.bold, color: primaryColor, fontSize: 15)),
            ],
          ),
          const SizedBox(height: 10),
          Text(desc, style: const TextStyle(fontSize: 14, height: 1.5, color: Color(0xFF64748B))),
          const SizedBox(height: 24),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: skills.map((s) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: isDark ? const Color(0xFF21262D) : const Color(0xFFF1F5F9),
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: borderColor),
                ),
                child: Text(s, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildWebProjectGrid(Color cardBg, Color borderColor, Color primary, Color textMuted, ThemeData theme, bool isDark) {
    final allProjects = [
      {
        'title': 'IoT BLDC Fan & Smart Home Control Ecosystem',
        'badge': 'IoT & Smart Home',
        'category': 'Flutter IoT',
        'desc': 'Smart-home application enabling low-latency BLE discovery, Wi-Fi provisioning, fan speed/timer adjustments, dynamic mood lighting controls, and Alexa/Google Home voice integrations with offline fallback support.',
        'tags': ['Flutter', 'BLE', 'MQTT', 'Wi-Fi', 'Alexa', 'Google Home'],
      },
      {
        'title': 'School Management Platform (EdTech)',
        'badge': 'Enterprise Flutter',
        'category': 'Flutter',
        'desc': 'Comprehensive role-based portal unifying 4 user tiers: Administrators, Teachers, Students, and Parents. Includes digital grade reporting, automated timetable scheduling, and Firebase notifications.',
        'tags': ['Flutter', 'REST APIs', 'RBAC Security', 'Firebase FCM'],
      },
      {
        'title': 'Core Desk – Workplace Collaboration & Analytics',
        'badge': 'Corporate Chat & Analytics',
        'category': 'Flutter',
        'desc': 'Distributed team collaboration hub with real-time peer messaging, task sprint tracking, velocity metrics, activity reports, and managerial review dashboards.',
        'tags': ['Flutter', 'WebSockets', 'Real-Time Messaging', 'Analytics'],
      },
      {
        'title': 'Employee Management & Geo-Fencing Attendance',
        'badge': 'Workforce Logistics',
        'category': 'FlutterFlow',
        'desc': 'Automated employee punch-in verification using hardware GPS geo-fencing perimeter bounds, leave management, approval hierarchies, and payroll exports.',
        'tags': ['FlutterFlow', 'GPS Geo-Fencing', 'Cloud Database', 'Workflows'],
      },
      {
        'title': 'Local Partner – E-Commerce & Rental Platform',
        'badge': 'Commercial Platform',
        'category': 'FlutterFlow',
        'desc': 'Dual-mode commerce app supporting outright item purchases and flexible multi-tier rental durations (daily, weekly, yearly) with integrated payment checkout.',
        'tags': ['FlutterFlow', 'REST APIs', 'Payment Gateways', 'Rental Logic'],
      },
      {
        'title': 'Lottery Management & Pooling Platform',
        'badge': 'FinTech & Pooling',
        'category': 'FlutterFlow',
        'desc': 'Secure syndicate pooling engine with live draw results, automated proportional payout calculations, user roles, and transactional notifications.',
        'tags': ['FlutterFlow', 'Payment Gateways', 'Live Telemetry', 'Pooling'],
      },
      {
        'title': 'IoT QA & AWS Cloud Infrastructure Migration',
        'badge': 'QA Leadership & Cloud',
        'category': 'QA & Cloud IoT',
        'desc': 'Led environmental sensor testing for Broan-NuTone Overture & Watkins Wellness smart spas. Migrated enterprise server instances from Windows to Ubuntu Linux on AWS EC2 with zero data loss.',
        'tags': ['AWS EC2 & S3', 'Ubuntu Linux', 'IoT Testing', 'Postman QA'],
      },
    ];

    final filtered = allProjects.where((p) {
      final category = p['category'] as String;
      if (_selectedCategory == 'All') return true;
      if (_selectedCategory == 'Flutter') return category.contains('Flutter');
      if (_selectedCategory == 'IoT') return category.contains('IoT');
      if (_selectedCategory == 'FlutterFlow') return category.contains('FlutterFlow');
      if (_selectedCategory == 'QA & Cloud') return category.contains('QA');
      return true;
    }).toList();

    return LayoutBuilder(
      builder: (context, constraints) {
        return Wrap(
          spacing: 24,
          runSpacing: 24,
          children: filtered.map((p) {
            return SizedBox(
              width: (constraints.maxWidth - 24) / 2,
              child: Container(
                padding: const EdgeInsets.all(28),
                decoration: BoxDecoration(
                  color: cardBg,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: borderColor),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: isDark ? const Color(0xFF21262D) : const Color(0xFFEFF6FF),
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: borderColor),
                      ),
                      child: Text(
                        p['badge'] as String,
                        style: GoogleFonts.jetBrainsMono(fontSize: 11, fontWeight: FontWeight.bold, color: primary),
                      ),
                    ),
                    const SizedBox(height: 14),
                    Text(
                      p['title'] as String,
                      style: TextStyle(fontWeight: FontWeight.w800, fontSize: 18, color: theme.colorScheme.onSurface),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      p['desc'] as String,
                      style: TextStyle(fontSize: 14, height: 1.6, color: textMuted),
                    ),
                    const SizedBox(height: 20),
                    Wrap(
                      spacing: 6,
                      runSpacing: 6,
                      children: (p['tags'] as List<String>).map((t) {
                        return Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: isDark ? const Color(0xFF21262D) : const Color(0xFFF1F5F9),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(t, style: GoogleFonts.jetBrainsMono(fontSize: 11, color: textMuted)),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }

  Widget _buildWebTimelineItem({
    required String period,
    required String role,
    required String company,
    required List<String> bullets,
    required List<String> tags,
    required Color cardBg,
    required Color borderColor,
    required Color primaryColor,
    required Color textMuted,
    required ThemeData theme,
  }) {
    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                role,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: theme.colorScheme.onSurface),
              ),
              Text(
                period,
                style: GoogleFonts.jetBrainsMono(fontSize: 13, fontWeight: FontWeight.bold, color: primaryColor),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(company, style: TextStyle(fontSize: 14, color: textMuted, fontWeight: FontWeight.w500)),
          const SizedBox(height: 16),
          ...bullets.map((b) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('— ', style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold)),
                  Expanded(
                    child: Text(b, style: TextStyle(fontSize: 14.5, height: 1.6, color: theme.colorScheme.onSurface)),
                  ),
                ],
              ),
            );
          }),
          const SizedBox(height: 14),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: tags.map((t) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFF1F5F9).withAlpha(128),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(t, style: GoogleFonts.jetBrainsMono(fontSize: 11, color: textMuted)),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildWebContactCard({
    required IconData icon,
    required String label,
    required String value,
    required VoidCallback onTap,
    required Color cardBg,
    required Color borderColor,
    required Color primaryColor,
    required ThemeData theme,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(22),
        decoration: BoxDecoration(
          color: cardBg,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: borderColor),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(30),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: primaryColor, size: 22),
            ),
            const SizedBox(height: 16),
            Text(label.toUpperCase(), style: GoogleFonts.jetBrainsMono(fontSize: 10, color: const Color(0xFF94A3B8), fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text(value, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: theme.colorScheme.onSurface)),
          ],
        ),
      ),
    );
  }
}
